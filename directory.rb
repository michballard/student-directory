require 'csv'
COHORT_MONTHS = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
DEFAULT_COHORT_MONTH = "August"
@students = []

def input_student
	# get the first student's details
	puts "What is the student name?"
	name = STDIN.gets.strip.capitalize
	return false if name.empty? 

	# obtain cohort and perform checks
	cohort = ""
	puts "Which cohort is #{name} in?"
	loop do
		cohort = STDIN.gets.strip.capitalize
		if cohort.empty?
			cohort = DEFAULT_COHORT_MONTH
			puts "August cohort selected as default"
			break
		elsif COHORT_MONTHS.include?(cohort)
			puts "Cohort verified"	
			break	
		else
			puts "Please re-enter cohort:"
		end
	end

	# enter further information
	puts "What are #{name}'s hobbies?"
	hobbies = STDIN.gets.chomp.downcase
	puts "Which country was #{name} born in?"
	cob = STDIN.gets.strip.upcase
	puts "What is #{name}'s height in cm?"
	height = STDIN.gets.chomp.to_i

	# return the student as a hash
	add_student(name, cohort, hobbies, cob, height)
	return true
end


def input_students
	puts "Please enter the details of each student"
	puts "To finish, just press return"
	# create an empty array
	loop do
		break if input_student == false
		print "Now we have #{@students.length} student"
		if @students.length != 1
			print "s"
		end
		print "\n"
	end	
end

def print_header
  header = "The students of my cohort at Makers Academy"
  line = "----------------------------"
  puts header.center(100) 
  puts line.center(100)
end

# def print_student(students)
#   students.each.with_index(1) do |student, index|
#     puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)"
#   end
# end

# Rewriting above code using "while" control flow method
# def print_student(studentlist)
# 	count = 0
# 	while count < studentlist.length 
# 		student = studentlist[count]
# 		count += 1		
# 		puts "#{count}. #{student[:name]} (#{student[:cohort]} cohort)"
# 	end
# end

# Rewriting above code using "until" control flow method
def print_students_list
	count = 0
	until count >= @students.length
		student = @students[count]
		count += 1			
		puts "#{count}. #{student[:name]} (#{student[:cohort]} cohort)"
		puts "   Hobbies: #{student[:hobbies]}\n   Birth country: #{student[:cob]}\n   Height: #{student[:height]}"
	end
end

def print_footer
	print "Overall, we have #{@students.length} great student"
	if @students.length != 1
	  	print "s"
	end
  	print "\n"
end

# Lists students only if there is 1 or more students saved in array
def show_students
	if @students.length <= 0
		puts "No students found in student list"
	else 
		print_header
		print_students_list
		print_footer
	end
end

# List only students whose name begins with a specified letter
def student_search
	puts "What is the starting letter you would like to search for?"
	# get the search character from user
	character = STDIN.gets.chomp.capitalize
	puts "Names starting with #{character}:"
	# perform search for character
	@students.select do |student| 
		puts "#{student[:name]}" if student[:name].start_with?(character)
	end
end

# List only students with names shorter than specified number of characters
def students_name_length
	puts "What is the required maximum number of characters in full name?"
	# get number of characters from user
	namelength = STDIN.gets.chomp.to_i
	puts "Names with up to #{namelength} characters:"
	# perform search for name lengths
	@students.select do |student|
		puts "#{student[:name]}" if student[:name].length <= namelength
	end
end	

# Lists students grouped by cohort
def cohorts
	cohortlist = (@students.map { |student| student[:cohort] }).uniq
	cohortlist.each do |cohort|
		puts "#{cohort} cohort:"
		@students.select do |student|
			puts "#{student[:name]}" if student[:cohort] == cohort
		end
	end
end

def print_menu
	puts "1. Input the students"
	puts "2. Show the students"
	puts "3. Save the list to students.csv"
	puts "4. Load the list from students.csv"
	puts "5. Show source code"
	puts "9. Exit" 
end

def save_students
	puts "What would you like to save as filename?"
	filename = gets.strip
	return if filename.empty?
	# open the file for writing
	File.open(filename, "w") do |file|
		# iterate over the array of students
		@students.each do |student|
			student_data = [student[:name], student[:cohort], student[:hobbies], student[:cob], student[:height]]
			csv_line = student_data.join(",")
			file.puts csv_line
		end
	end
end

def add_student(name, cohort, hobbies = "", cob = "", height = 0)
	@students << {name: name, cohort: cohort.to_sym, hobbies: hobbies, cob: cob, height: height}
end

# Loads student list from specified CSV
def load_students(filename)
	if File.exists?(filename) # if it exists
		CSV.foreach(filename) do |line|
			add_student(line[0], line[1])
		end
		puts "Loaded #{@students.length} from #{filename}"
	else # if it doesn't exist
		puts "Sorry, #{filename} doesn't exist."
		exit # quit the program
	end
end

# Performs check whether filename has been entered
def query_load_students
	puts "What filename would you like to load?"
	filename = gets.chomp
	return if filename.empty?
	load_students(filename)
end

# If specified in command line, loads csv file
def try_load_students
	filename = ARGV.first # first argument from the command line
	return if filename.nil? # get out of the method if it isn't given
	load_students(filename)
end	

# Shows source code
def code_content
	puts File.read(__FILE__)
end

def process(selection)
	case selection
		when "1"
			# input the students
			input_students
		when "2"
			# show the students
			show_students
		when "3"
			save_students
		when "4"
			query_load_students
		when "5"
			code_content
		when "9"
			exit #this will cause the program to terminate
		else
			puts "I don't know what you meant, try again"
	end 
end

def interactive_menu
	loop do
		print_menu
		process(STDIN.gets.chomp)
	end
end

try_load_students
interactive_menu

# student_search(@students)
# students_name_length(@students)
# cohorts(@students)