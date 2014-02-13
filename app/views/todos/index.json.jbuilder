json.array!(@todos) do |todo|
  json.extract! todo, :id, :name, :descrption, :project_id, :user_id, :status
  json.url todo_url(todo, format: :json)
end
