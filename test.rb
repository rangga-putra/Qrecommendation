require 'net/http'
require 'json'

urinilai = URI('http://5c6f9b3369738000148aeab0.mockapi.io/assessment')

resnilai = Net::HTTP.get_response(urinilai)

puts JSON.parse(resnilai.body)
