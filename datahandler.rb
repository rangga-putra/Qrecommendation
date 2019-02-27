require 'net/http'
require 'json'

def getdata(params)
  uri = URI(params)
  res = Net::HTTP.get_response(uri)
  JSON.parse(res.body)
end

def aggregatedata(assessments)
  result = {}
  assessments.each do |assessment|
    assessment['nilai'].each do |k, v|
      result[k] = result[k].to_i + v
    end
  end

  result['user_id'] = assessments.first['userid']

  result.update(result) do |k, v|
    k.include?('id') ? v : (v / assessments.length.to_f).round(2)
  end
end
