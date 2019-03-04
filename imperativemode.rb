require 'net/http'
require 'json'

# json uri and response
urijurusan = URI('http://5c6f9b3369738000148aeab0.mockapi.io/new_study_fields')
urinilai = URI('http://5c6f9b3369738000148aeab0.mockapi.io/new_assessment')

resjurusan = Net::HTTP.get_response(urijurusan)
resnilai = Net::HTTP.get_response(urinilai)

# parse json
studyfields = JSON.parse(resjurusan.body)
assessments = JSON.parse(resnilai.body)

result = {}

assessments.each do |assessment|
  assessment['nilai'].each do |k, v|
    result[k] = result[k].to_i + v
  end
end

result['user_id'] = assessments.first['userid']

# puts result

score = result.update(result) do |k, v|
  k.include?('id') ? v : (v / assessments.length.to_f).round(2)
end

# puts score

# bobot = {
#   'matematika'=> item[]
# }

studyfields.each do |item|
  item['nilai'].update(item['nilai']) do |k, v|
    if k == 'bobot_matematika_ips'
      (v * score['matematika_ips']).round(2)
    elsif k == 'bobot_matematika_ipa'
      (v * score['matematika_ipa']).round(2)
    elsif k == 'bobot_geografi'
      (v * score['geografi']).round(2)
    elsif k == 'bobot_ekonomi'
      (v * score['ekonomi']).round(2)
    elsif k == 'bobot_sosiologi'
      (v * score['sosiologi']).round(2)
    elsif k == 'bobot_sejarah'
      (v * score['sejarah']).round(2)
    elsif k == 'bobot_fisika'
      (v * score['fisika']).round(2)
    elsif k == 'bobot_biologi'
      (v * score['biologi']).round(2)
    elsif k == 'bobot_bahasa_indonesia'
      (v * score['bahasa_indonesia']).round(2)
    end
  end
end

puts studyfields

puts '=========================================='
sorted = studyfields.sort_by { |h| h['total'] }.reverse
puts sorted

rekomendasi = sorted.to_json
puts '=========================================='
puts rekomendasi
puts '=========================================='
puts 'kami merekomendasikan 3 jurusan terbaik buat kamu berdasarkan nilaimu'
puts '3 jurusan tersebut adalah sebagai berikut : '
puts "1. #{sorted[0]['nama_jurusan']} "
puts "2. #{sorted[1]['nama_jurusan']} "
puts "3. #{sorted[2]['nama_jurusan']} "
