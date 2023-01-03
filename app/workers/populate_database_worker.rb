class PopulateDatabaseWorker
  include Sidekiq::Worker

  def perform(*_args)
    populate_database
  end

  def fetch_sneakers
    server = HTTP.headers('x-rapidapi-host': ENV.fetch('RAPIDAPI_HOST', nil),
                          'x-rapidapi-key': ENV.fetch('RAPIDAPI_KEY', nil))
      .get(ENV.fetch('URL', nil))
    response = server.parse
  rescue StandardError => e
    puts e
  else
    response['results']
  end

  def populate_database
    sneakers = fetch_sneakers
    return if sneakers.nil?

    sneakers.each do |sneaker|
      shoe_id = sneaker['id']
      brand_name = sneaker['brand']
      gender_name = sneaker['gender']
      title = sneaker['title']
      name = sneaker['name']
      release_date = sneaker['releaseDate']
      price = (sneaker['retailPrice']).zero? ? 110 : sneaker['retailPrice']
      colors = sneaker['colorWay']
      image_url = sneaker['media']['imageUrl'] || sneaker['media']['smallImageUrl'] || sneaker['media']['thumbUrl']
      next unless image_url

      ActiveRecord::Base.transaction do
        brand = create_brand(brand_name)
        gender = create_gender(gender_name)
        create_sneaker(
          { shoe_id:,
            title:,
            colors:,
            name:,
            release_date:,
            price:,
            image_url:,
            brand:,
            gender: }
        )
      end
    end
  end

  def create_brand(name)
    brand = Brand.find_by_name(name.downcase)
    return brand unless brand.nil?

    Brand.create!(name: name.downcase)
  end

  def create_gender(name)
    gender = Gender.find_by_name(name)
    return gender unless gender.nil?

    Gender.create!(name: name.downcase)
  end

  def create_sneaker(sneaker_params)
    sneaker = Sneaker.find_by_shoe_id(sneaker_params[:shoe_id])
    return unless sneaker.nil?

    Sneaker.create!(
      sneaker_params
    )
  end
end
