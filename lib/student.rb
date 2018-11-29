require 'pry'
class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE students (id INTEGER PRIMARY KEY, name TEXT, grade INTEGER);
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
    DROP TABLE students;
    SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
    INSERT INTO students (name, grade) VALUES ( ?, ?)
    SQL
    DB[:conn].execute(sql, name, grade)

    sql2 = <<-SQL
    SELECT id FROM students ORDER BY id DESC LIMIT 1
    SQL
    @id = DB[:conn].execute(sql2).flatten[0] # returns an array of arrays?
    # binding.pry
  end

  def self.create(name:, grade:)
    new = Student.new(name, grade); new.save ; new
  end

end
