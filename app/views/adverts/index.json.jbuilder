json.array!(@adverts) do |advert|
  json.extract! advert, :id, :title, :description, :image_url
  json.url advert_url(advert, format: :json)
end
