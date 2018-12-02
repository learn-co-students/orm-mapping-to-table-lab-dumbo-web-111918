require 'pry'
class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
  	@id = id
   	@name = name
   	@grade = grade
  end

  	# this below is a class method that creates the students table.
  	# Use a heredoc to set a variable, sql, equal to the necessary SQL
  	# statement. Remember, the attributes of a student, name, grade, and id,
  	# should correspond to the column names you are creating in your students
  	# table. The id column should be the primary key.
  	def self.create_table
  	sql = <<-SQL
  	CREATE TABLE IF NOT EXISTS students (
       id INTEGER PRIMARY KEY,
       name TEXT,
       grade TEXT
       )
       SQL
       DB[:conn].execute(sql)
     end

     def self.drop_table
     	 sql =
     	 "DROP TABLE students"
       DB[:conn].execute(sql)
     end


     def save
     	 sql = <<-SQL
         INSERT INTO students(name, grade)
         VALUES (?, ?)
       SQL

       DB[:conn].execute(sql, self.name, self.grade)
       @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
      end

     def self.create(name:, grade:)
     	#this is a student instance that is being created inside class method
     	#like def initialize but with a save
     	 student = Student.new(name, grade)
     	 #student.grade=(grade)
     	 student.save
     	 student
      end
end
