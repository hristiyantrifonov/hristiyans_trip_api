class TripsQuery
  SORT_DIRECTIONS = %w[asc desc].freeze

  DEFAULT_SORT_ORDER = "asc"
  DEFAULT_DEFAULT_SORT = "name"
  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 10
  MAX_PER_PAGE = 20

  def initialize(scope = Trip.all, params = {})
    @scope = scope
    @params = params
  end

  def call
    results = @scope
    results = apply_search(results)
    results = apply_min_rating_filter(results)
    results = apply_sort(results)

    {
      trips: apply_pagination(results),
      pagination: pagination_metadata(results)
    }
  end

  private

  attr_reader :params

  def apply_search(scope)
    return scope if params[:search].blank?

    term = "%#{sanitize_like(params[:search].to_s.strip)}%"

    scope.where(
      "name ILIKE :term OR short_description ILIKE :term OR long_description ILIKE :term",
      term: term
    )
  end

  def apply_min_rating_filter(scope)
    return scope if params[:min_rating].blank?

    min_rating = params[:min_rating].to_i
    return scope.none unless min_rating.between?(1, 5)

    scope.where("rating >= ?", min_rating)
  end

  def apply_sort(scope)
    direction =
      if SORT_DIRECTIONS.include?(params[:order].to_s.downcase)
        params[:order].to_s.downcase
      else
        DEFAULT_SORT_ORDER
      end

    if params[:sort] == "rating"
      scope.order(Arel.sql("rating #{direction}, name asc"))
    else
      scope.order(Arel.sql("name asc"))
    end
  end

  def apply_pagination(scope)
    scope.limit(per_page).offset((page - 1) * per_page)
  end

  def page
    value = params[:page].to_i
    value.positive? ? value : DEFAULT_PAGE
  end

  def per_page
    value = params[:per_page].to_i
    return DEFAULT_PER_PAGE unless value.positive?

    [value, MAX_PER_PAGE].min
  end

  def pagination_metadata(results)
    total = results.unscope(:limit, :offset, :order).count

    {
      current_page: page,
      per_page: per_page,
      total_trips: total,
      total_pages: total.zero? ? 0 : (total.to_f / per_page).ceil
    }
  end

  def sanitize_like(value)
    ActiveRecord::Base.sanitize_sql_like(value)
  end
end