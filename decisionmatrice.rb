def weightmultiplication(item, score)
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

def totalscore(item)
  item['total'] = item['nilai'].sum { |_k, v| v }
end

def recommendation(score, studyfields)
  studyfields.each do |item|
    weightmultiplication(item, score)
    totalscore(item)
  end
  studyfields.sort_by { |hash| hash['total'] }.reverse
end

def pesanrekom(rekom)
  puts 'berdasarkan nilai nilai assessment kamu, kami merekomendasikan 3'
  puts 'jurusan berikut ini nih :'
  rekom[0..2].each_with_index do |item, index|
    puts "#{index + 1}. #{item['nama_jurusan']}"
  end
end
