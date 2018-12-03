class Student
	attr_accessor :name, :grade
	attr_reader :id

	def initialize(name, grade, id=nil)
		@name = name
		@grade = grade
		@id = id
	end

	def self.create_table
		sql = <<-SQL
		CREATE TABLE students (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		name TEXT,
		grade TEXT
		);
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
		INSERT INTO students (name, grade)
		VALUES ("#{@name}", "#{@grade}");
		SQL
		DB[:conn].execute(sql)

		sql = <<-SQL
		SELECT last_insert_rowid() FROM students;
		SQL
		@id = DB[:conn].execute(sql)[0][0]
	end

	def self.create(hash)
		n = Student.new(hash[:name], hash[:grade])
		n.save
		n
	end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

end
