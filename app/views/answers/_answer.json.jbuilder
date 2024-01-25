json.extract! answer, :id, :question_id, :body, :evaluation, :created_at, :updated_at
json.url answer_url(answer, format: :json)
