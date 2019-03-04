require 'net/http'
require 'json'

def getdata(params)
  uri = URI(params)
  res = Net::HTTP.get_response(uri)
  JSON.parse(res.body)
end

def aggregatedata(assessments, listofstudyfields)
  fields = listofstudyfields[0]['study_field_list']
  score = Hash[fields.map { |x| [x, 0] }]

  assessments.each do |assessment|
    assessment['nilai'].each do |k, v|
      score[k] = score[k].to_i + v
    end
  end

  score.update(score) do |k, v|
    k.include?('user_id') ? v : (v / assessments.length.to_f).round(2)
  end
end
