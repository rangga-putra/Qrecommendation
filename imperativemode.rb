require 'net/http'
require 'json'

# json uri and response
urijurusan = URI('http://5c6f9b3369738000148aeab0.mockapi.io/new_study_fields')
urinilai = URI('http://5c6f9b3369738000148aeab0.mockapi.io/new_assessment')
urilistjurusan = URI('http://5c6f9b3369738000148aeab0.mockapi.io/study_field_list')

resjurusan = Net::HTTP.get_response(urijurusan)
resnilai = Net::HTTP.get_response(urinilai)
reslistjurusan = Net::HTTP.get_response(urilistjurusan)

# parse json
studyfields = JSON.parse(resjurusan.body)
assessments = JSON.parse(resnilai.body)
listofstudyfields = JSON.parse(reslistjurusan.body)

#============================================================================
# init

fields = listofstudyfields[0]['study_field_list']

score = Hash[fields.map { |x| [x, 0] }]

assessments.each do |assessment|
  assessment['nilai'].each do |k, v|
    score[k] = score[k].to_i + v
  end
end

score.update(score) do |k, v|
  k.include?('id') ? v : (v / assessments.length.to_f).round(2)
end

# assessment score end here
#===============================================================================

studyfields.each do |studyfield|
  studyfield['nilai'].merge!(score) { |_key, oldval, newval| oldval * newval }
  studyfield['total'] = studyfield['nilai'].sum { |_k, v| v }
end

sorted = studyfields.sort_by { |h| h['total'] }.reverse

puts 'kami merekomendasikan 3 jurusan terbaik buat kamu berdasarkan nilaimu'
puts '3 jurusan tersebut adalah sebagai berikut : '
puts "1. #{sorted[0]['nama_jurusan']} "
puts "2. #{sorted[1]['nama_jurusan']} "
puts "3. #{sorted[2]['nama_jurusan']} "
