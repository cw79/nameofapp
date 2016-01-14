# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Product.create(:image_url => "100label_product.png", :name => "100%", :description => "Unsweetened chocolate with an intense uncompromising taste. Forastero beans from the Ivory Coast.", :price => "6")
Product.create(:image_url => "91label_product.png", :name => "91%", :description => "Ecuador's highly prized Nacional bean provides this dark chocolate with a robust, full-bodied flavor. Bitter overtones and subtle smoky notes.", :price => "6")
Product.create(:image_url => "82label_product.png", :name => "82%", :description => "Peruvian Criollo and Trinitarian beans perfectly blended to produce a luxurious, full flavored dark chocolate. Rich and decadent, with an understated bitterness and hints of acidity.", :price => "6")
Product.create(:image_url => "70label_product.png", :name => "70%", :description => "A drying process unique to Vietnam's Mekong Delta means these Trinitario beans develop a rich, fruity flavor. Extremely smooth with a little spice and sweet to finish.", :price => "6")
Product.create(:image_url => "48label_product.png", :name => "48%", :description => "Trinitarian bean sourced in Costa Rica with rich, pronounced cocoa notes. Warm and smooth milk chocolate.", :price => "6")
Product.create(:image_url => "43label_product.png", :name => "43%", :description => "Criollo and Trinitario beans grown in Venezuala are blended to give an impression of roasted cocoa. This rich milk chocolate has a clear vanilla aroma and definite flavors of caramel and hazelnut.", :price => "6")
Product.create(:image_url => "37label_product.png", :name => "37%", :description => "Prized Indonesian Java beans produce this delicious blonde milk chocolate. Light in color, it displays hints of caramel, toffee, and vanilla.", :price => "6")
Product.create(:image_url => "35label_product.png", :name => "35%", :description => "A notably high cocoa butter content creates a creamy, smooth white chocolate. Satisfyingly sweet with an endnote of vanilla.", :price => "6")

