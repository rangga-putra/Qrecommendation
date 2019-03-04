def weightmultiplication(studyfields, score)
  studyfields.each do |studyfield|
    studyfield['nilai'].merge!(score) { |_key, oldval, newval| oldval * newval }
    studyfield['total'] = studyfield['nilai'].sum { |_k, v| v }
  end
end

def recommendation(score, studyfields)
  weightmultiplication(studyfields, score)
  studyfields.sort_by { |h| h['total'] }.reverse
end

def pesanrekom(rekom)
  puts 'berdasarkan nilai nilai assessment kamu, kami merekomendasikan 3'
  puts 'jurusan berikut ini nih :'
  rekom[0..2].each_with_index do |item, index|
    puts "#{index + 1}. #{item['nama_jurusan']}"
  end
end
