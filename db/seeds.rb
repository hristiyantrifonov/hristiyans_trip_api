Trip.destroy_all

Trip.create!([
               {
                 name: "Grand Canyon National Park",
                 image_url: "https://images.unsplash.com/photo-1501785888041-af3ef285b470",
                 short_description: "Vast red rock canyon carved by the Colorado River.",
                 long_description: <<~TEXT,
      Stretching 277 miles long and over a mile deep, the Grand Canyon reveals nearly two billion years of Earth's history through its colorful layers of rock. Visitors can hike, raft, or simply take in the breathtaking views from the rim, watching the light shift across the canyon walls throughout the day.
    TEXT
                 rating: 5
               },
               {
                 name: "Carhenge",
                 image_url: "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
                 short_description: "Stonehenge replica made entirely from vintage cars.",
                 long_description: <<~TEXT,
      Located near Alliance, Nebraska, Carhenge recreates the famous English monument using 38 old automobiles painted gray and arranged in the same proportions as the original. It’s a quirky celebration of both art and Americana that attracts thousands of visitors each year.
    TEXT
                 rating: 4
               },
               {
                 name: "Joshua Tree National Park",
                 image_url: "https://images.unsplash.com/photo-1519681393784-d120267933ba",
                 short_description: "Iconic desert park known for its unique Joshua trees.",
                 long_description: <<~TEXT,
      Where the Mojave and Colorado deserts meet, Joshua Tree National Park is a land of rugged rock formations and stark desert beauty. Named for its spiky, twisted trees, the park offers world-class climbing, stargazing, and the kind of silence that’s hard to find anywhere else.
    TEXT
                 rating: 5
               },
               {
                 name: "World’s Largest Ball of Twine",
                 image_url: "https://images.unsplash.com/photo-1506744038136-46273834b3fb",
                 short_description: "A roadside legend in Cawker City, Kansas.",
                 long_description: <<~TEXT,
      Started by a single resident in 1953, this enormous ball of sisal twine has been growing ever since, thanks to contributions from locals and travelers alike. It stands as a living monument to small-town pride, oddity, and community spirit.
    TEXT
                 rating: 3
               },
               {
                 name: "Mount Rushmore",
                 image_url: "https://images.unsplash.com/photo-1586974772928-9e4d0efcc9ab",
                 short_description: "Famous presidential monument carved into granite.",
                 long_description: <<~TEXT,
      Sculpted into the Black Hills of South Dakota, Mount Rushmore features the faces of Washington, Jefferson, Roosevelt, and Lincoln. The monument took 14 years to complete and stands as a tribute to the nation’s founding, growth, and preservation.
    TEXT
                 rating: 4
               },
               {
                 name: "Salvation Mountain",
                 image_url: "https://images.unsplash.com/photo-1570129477492-45c003edd2be",
                 short_description: "A technicolor art installation in the desert.",
                 long_description: <<~TEXT,
      Created by artist Leonard Knight, Salvation Mountain is a massive, hand-built monument proclaiming love and faith through bright paint, adobe, and straw. Its kaleidoscope colors and handmade details make it one of California’s most photographed outsider art sites.
    TEXT
                 rating: 5
               },
               {
                 name: "Antelope Canyon",
                 image_url: "https://images.unsplash.com/photo-1501594907352-04cda38ebc29",
                 short_description: "A sandstone slot canyon of swirling colors.",
                 long_description: <<~TEXT,
      Carved by centuries of flash flooding, Antelope Canyon in Arizona is a masterpiece of nature’s sculpting. Light beams filter through narrow openings, illuminating the orange and purple waves of sandstone, creating an otherworldly atmosphere beloved by photographers.
    TEXT
                 rating: 5
               },
               {
                 name: "Cadillac Ranch",
                 image_url: "https://images.unsplash.com/photo-1614463161951-c33c6bdb2d58",
                 short_description: "Ten Cadillacs buried nose-first in the Texas desert.",
                 long_description: <<~TEXT,
      A public art installation outside Amarillo, Cadillac Ranch was created in 1974 by a group called Ant Farm. The half-buried cars span the evolution of the Cadillac tailfin, and visitors are encouraged to add their own spray-painted art, keeping the exhibit ever-changing.
    TEXT
                 rating: 4
               },
               {
                 name: "Devils Tower",
                 image_url: "https://images.unsplash.com/photo-1536334720751-0e4a3f2b7a0e",
                 short_description: "Towering volcanic monolith in Wyoming.",
                 long_description: <<~TEXT,
      Rising dramatically from the plains of Wyoming, Devils Tower is a striking natural formation revered by Native American tribes and known as the nation’s first national monument. Its fluted columns are a favorite among climbers and photographers alike.
    TEXT
                 rating: 5
               },
               {
                 name: "Roswell UFO Museum",
                 image_url: "https://images.unsplash.com/photo-1526498460520-4c246339dccb",
                 short_description: "Dive into UFO lore and alien encounters.",
                 long_description: <<~TEXT,
      The International UFO Museum in Roswell, New Mexico explores the mystery of the alleged 1947 UFO crash. Packed with exhibits, photos, and first-hand accounts, it’s a pilgrimage site for believers, skeptics, and pop-culture enthusiasts alike.
    TEXT
                 rating: 3
               },
               {
                 name: "Niagara Falls",
                 image_url: "https://images.unsplash.com/photo-1506744038136-46273834b3fb",
                 short_description: "World-famous waterfalls between the US and Canada.",
                 long_description: <<~TEXT,
      Niagara Falls’ massive cascades send over 3,000 tons of water per second tumbling down its cliffs. Visitors can view the spectacle from both sides of the border, take a boat into the mist, or marvel at nighttime light shows and fireworks.
    TEXT
                 rating: 5
               },
               {
                 name: "Bonneville Salt Flats",
                 image_url: "https://images.unsplash.com/photo-1500534314209-a25ddb2bd429",
                 short_description: "Utah’s surreal expanse of pure white salt.",
                 long_description: <<~TEXT,
      A remnant of ancient Lake Bonneville, these vast flats stretch for miles and create a mirror-like effect after rain. They serve as a natural racetrack for land speed records and a photographer’s dream for minimalist landscapes.
    TEXT
                 rating: 4
               },
               {
                 name: "Crater Lake National Park",
                 image_url: "https://images.unsplash.com/photo-1570129477492-45c003edd2be",
                 short_description: "A deep volcanic lake with brilliant blue water.",
                 long_description: <<~TEXT,
      Formed nearly 8,000 years ago by the collapse of Mount Mazama, Oregon’s Crater Lake is the deepest in the United States. Its pristine waters and steep surrounding cliffs make it one of the most spectacular natural sights in the Pacific Northwest.
    TEXT
                 rating: 5
               },
               {
                 name: "Mystery Spot",
                 image_url: "https://images.unsplash.com/photo-1587502537745-84b80b1f3f19",
                 short_description: "Optical illusion attraction in Santa Cruz.",
                 long_description: <<~TEXT,
      Since the 1940s, the Mystery Spot has baffled visitors with tilted rooms and gravity-defying effects. Whether a trick of perspective or something stranger, it remains one of California’s most enduring roadside curiosities.
    TEXT
                 rating: 4
               },
               {
                 name: "Sequoia National Park",
                 image_url: "https://images.unsplash.com/photo-1503264116251-35a269479413",
                 short_description: "Home of the world’s largest trees.",
                 long_description: <<~TEXT,
      California’s Sequoia National Park shelters the giant sequoias — ancient trees that can live over 3,000 years and tower more than 250 feet high. The General Sherman Tree, the world’s largest by volume, inspires awe in all who stand beneath it.
    TEXT
                 rating: 5
               },
               {
                 name: "South of the Border",
                 image_url: "https://images.unsplash.com/photo-1596484557299-8fc5d9aa66e9",
                 short_description: "Neon roadside landmark along I-95.",
                 long_description: <<~TEXT,
      Straddling the North Carolina–South Carolina line, South of the Border has been luring travelers for decades with its colorful billboards, giant sombrero tower, and kitschy charm. It’s equal parts nostalgic tourist trap and road trip rite of passage.
    TEXT
                 rating: 3
               },
               {
                 name: "Bryce Canyon National Park",
                 image_url: "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
                 short_description: "Maze of crimson spires called hoodoos.",
                 long_description: <<~TEXT,
      Bryce Canyon’s amphitheaters of red and orange rock formations glow vividly at sunrise. Its high-elevation trails weave among whimsical pillars carved by frost and erosion, offering one of the most surreal landscapes in the American West.
    TEXT
                 rating: 5
               },
               {
                 name: "Route 66 Museum",
                 image_url: "https://images.unsplash.com/photo-1530789253388-582c481c54b0",
                 short_description: "Celebrating America’s historic highway.",
                 long_description: <<~TEXT,
      Located in Oklahoma, this museum traces the cultural legacy of Route 66 — the ‘Mother Road’ that connected Chicago to Los Angeles. Through vintage cars, neon signs, and personal stories, it captures the romance of mid-century American travel.
    TEXT
                 rating: 4
               },
               {
                 name: "Arches National Park",
                 image_url: "https://images.unsplash.com/photo-1501785888041-af3ef285b470",
                 short_description: "Landscape filled with over 2,000 natural arches.",
                 long_description: <<~TEXT,
      Arches National Park, in Utah’s red rock country, is a wonderland of delicate sandstone arches, spires, and fins. Sunrise and sunset turn the formations fiery red, creating unforgettable views and endless opportunities for exploration.
    TEXT
                 rating: 5
               },
               {
                 name: "The Wave, Arizona",
                 image_url: "https://images.unsplash.com/photo-1518837695005-2083093ee35b",
                 short_description: "Famous swirling rock formation near the Utah border.",
                 long_description: <<~TEXT,
      Hidden within the Paria Canyon–Vermilion Cliffs Wilderness, The Wave is a geological masterpiece of undulating sandstone. Its surreal patterns and vivid stripes draw photographers from around the world — though only a handful of daily visitors are permitted via lottery.
    TEXT
                 rating: 5
               }
             ])