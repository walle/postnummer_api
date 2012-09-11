#encoding: utf-8

require 'json'
require 'postnummer'

get '/' do
  redirect 'http://postnummer.info', 301
end

get '/v1/zip_codes/:zip_code' do |zip_code|
  callback = params.delete('callback')
  json = '{"error": "På grund av ett cease and desist brev från posten är tyvärr tjänsten nerstängd. Se http://postnummer.info för mer information."}'

  if callback
    content_type :js
    response = "#{callback}(#{json})"
  else
    content_type :json
    json
  end
end
