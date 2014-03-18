require 'task'

class List
  attr_reader :name, :id

  def initialize(name, id)
    @name = name
    @id = id
  end

  def ==(another_list)
    self.name == another_list.name
  end

  def self.all
    results = DB.exec("SELECT * FROM lists;")
    lists = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      lists << List.new(name, id)
    end
    lists
  end

  def save
    results = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def return_tasks(query_name)
    tasks = []
    results = DB.exec("SELECT * FROM tasks WHERE ('#{@name}' = '#{query_name}');")
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      tasks << name
    end
    tasks
    end

end
