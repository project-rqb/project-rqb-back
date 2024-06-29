10.times do |i|
  Task.find_or_create_by(name: "Task #{i}", description: "Description #{i}")
end