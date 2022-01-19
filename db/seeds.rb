# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).



def get_sneakers
  begin
    p 'Starting Request'
    server = HTTP.headers("x-rapidapi-host": ENV['RAPIDAPI_HOST'],
      "x-rapidapi-key": ENV['RAPIDAPI_KEY'])
      .get(ENV['URL'])
    response = server.parse
    p 'Request Completed'
  rescue => exception
    puts exception
  else
    response['results']   
  end
end

def populate_database
  sneakers = get_sneakers
  return if sneakers.nil?
  sneakers.each do |sneaker|
    shoe_id = sneaker['id']
    brand_name = sneaker['brand']
    gender_name = sneaker['gender']
    title = sneaker['title']
    name = sneaker['name']
    release_date = sneaker['releaseDate']
    price = sneaker['retailPrice'] == 0 ? 110 : sneaker['retailPrice']
    colors = sneaker['colorWay']
    image_url = sneaker['media']['imageUrl'] || sneaker['media']['smallImageUrl'] || sneaker['media']['thumbUrl']
    if image_url
      ActiveRecord::Base.transaction do 
        brand = create_brand(brand_name)
        gender = create_gender(gender_name)
        create_sneaker(
          shoe_id, title, name, colors, release_date, price, image_url, brand, gender
          )
      end
    end
  end
end

def create_brand(name)
  brand = Brand.find_by_name(name.downcase)
  return brand  unless brand.nil?
  Brand.create!(name: name.downcase)
end

def create_gender(name)
  gender = Gender.find_by_name(name)
  return gender unless gender.nil?
  Gender.create!(name: name.downcase)

end

def create_sneaker(shoe_id, title, name, colors, release_date, price, image_url, brand, gender)
  sneaker = Sneaker.find_by_shoe_id(shoe_id)
  return unless sneaker.nil?
  Sneaker.create!(
    shoe_id: shoe_id,
    title: title,
    colors: colors,
    name: name,
    release_date: release_date,
    price: price,
    image_url: image_url,
    brand: brand,
    gender: gender
  )
end

populate_database