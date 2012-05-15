require 'json'
require 'postnummer'

get '/' do
  redirect 'http://postnummer.info', 301
end

get '/v1/zip_codes/:zip_code' do |zip_code|
  callback = params.delete('callback')
  json = Postnummer::Parser.new(zip_code).parse.map do |street|
    {
      name: street.name,
      first_number: street.first_number,
      last_number: street.last_number,
      zip_code: street.zip_code,
      city: street.city
    }
  end.to_json

  if callback
    content_type :js
    response = "#{callback}(#{json})"
  else
    content_type :json
    json
  end
end
