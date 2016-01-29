class Task
  attr_reader :title,
              :description,
              :id

  def initialize(data)
    @idea = data["id"]
    @title = data["title"]
    @description = data["description"]
  end
end
