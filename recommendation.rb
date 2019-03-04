require_relative 'datahandler'
require_relative 'decisionmatrice'

# get assessment score
score = getdata('http://5c6f9b3369738000148aeab0.mockapi.io/new_assessment')

# get studyfields list
studyfields_list = getdata('http://5c6f9b3369738000148aeab0.mockapi.io/study_field_list')

# puts score
aggregated_score = aggregatedata(score, studyfields_list)

# get studyfields weights
studyfields = getdata('http://5c6f9b3369738000148aeab0.mockapi.io/new_study_fields')

# do decision matrice calculation and return top 3 study fields recommendations
recommendation_score = recommendation(aggregated_score, studyfields)

pesanrekom(recommendation_score)
