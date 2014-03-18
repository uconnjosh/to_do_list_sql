require 'pg'



class Task
  attr_reader :name, :id, :results

   def initialize(name, id)
    @name = name
    @id = id
  end

  def self.all
    results = DB.exec("SELECT * FROM tasks;")
    tasks = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      tasks << Task.new(name, id)
    end
    tasks
  end

  def save
    DB.exec("INSERT INTO tasks (name, id) VALUES ('#{@name}','#{@id}');")
  end

  def ==(another_task)
    self.name == another_task.name && self.id == another_task.id
  end

  def delete
    DB.exec("DELETE FROM tasks WHERE id = ('#{@id}')")
  end
end

