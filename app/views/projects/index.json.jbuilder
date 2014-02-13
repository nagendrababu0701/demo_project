json.array!(@projects) do |project|
  json.extract! project, :id, :name, :descrption
  json.url project_url(project, format: :json)
end
