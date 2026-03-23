# Documentation for Hristiyan's Trip API

Implements a simple API Rails application that runs in a Docker container and allows for trips viewing, creation, sorting and searching.
It also has a background job that analyzes average trip rating and uses caching for better user experience.

The app is built using
- ruby 3.3.6
- Rails 8.1.2
- Docker version 27.5.1

# How to set up and run locally

The application ships with production-ready `Dockerfile` and development-ready `Dockerfile.dev`

To build the docker container (with Dockerfile.dev) and run the application locally you can use command:

```
docker compose up --build
```

The application should start running and you can see the result in `http://0.0.0.0:3000/api/v1/trips`

---

If you already have local required installs to run the application You can then run through those steps

- Install gems with Bundler

```
bundle install
```

- Install Solid Queue too

```
bin/rails solid_queue:install
```

- Run the migrations to get all the necessary DB changes in

```
bin/rails db:migrate
```

- Seed the database with the repo-provided seed file (adds 20 trips with various ratings)

```
bin/rails db:seed
```

- Run the Trips API using

```
bin/rails server
```

---

# How to run the test suite

Tests have been written to ensure API behaviour and components correctness. <br/>
Those include tests for Trip model validations; Trips creation; POST and GET requests behavioud; background job correctness and API refusal of incorrect inputs.

Tests can be ran using command

```
bundle exec rspec
```

---

# Versioning

The api is built so that future versioning of various components is seemless. <br/>
The current repository is at `v1` and changing to future versions could be done by making the respective edits to the `namespace` of `routes.rb`

---

# Design decisions and trade-offs

### Architecture
- API-only Rails app — No views, just JSON responses
- Versioned API (/api/v1/) — Allows future backwards compatibility
- Simple REST — Only index, show, create (no update/delete exposed

### Data Layer
- Single model (Trip)
- Validation on fields — URI format for image_url, ratings allowed from 1 to 5
- Database indexes on rating and image_url for query performance

### Query Handling
- Query Object pattern (TripsQuery) — Separates query logic from controller
- Parameterized queries — Prevents SQL injection
- Pagination with MAX_PER_PAGE=20 — Limits DB load
- ILIKE for searching functionality — Case-insensitive

### Caching Strategy
- 1-minute cache on index — Fast reads, but stale data for up to 60s
- Cache versioning with bump — Manual cache invalidation on creation of a new trip
- Trade-off: Simplicity over consistency; I built on the assumption that the API will be read-heavy

### Serializers
 - Two serializers (TripSummarySerializer, TripDetailSerializer) — Different payloads for listing all trips vs detailed views                                      
 - Manual serialization — No gem dependency (e.g., active_model_serializers), but more boilerplate

 ### Async Processing
 - Background job for avg rating calculation — The job just logs, doesn't store result

 ---

 # Improvements over time

We could have the background job be more complex and start to store the average rating result for easier reference and statistics

Additionally we could built upon the production-ready Dockerfile to make sure that Solid Queue database requirements are done automatically instead of
relying on a programmer to pre-setup the database.
