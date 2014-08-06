def input_students
	print "Please enter the details of each student\n"
	print "To finish, just press return twice\n"
	# create an empty array
	students = []
	# get the first student's details
	puts "What is the student name?"
	name = gets.chomp
	puts "Which cohort is #{name} in?"
	cohort = gets.chomp
	puts "What are #{name}'s hobbies?"
	hobbies = gets.chomp
	puts "Which country was #{name} born in?"
	cob = gets.chomp
	puts "What is #{name}'s height in cm?"
	height = gets.chomp
	# while the name is not empty, repeat this code
	while !name.empty? do
		# add the student hash to the array
		students << {:name => name.capitalize, :cohort => cohort.capitalize, :hobbies => hobbies.downcase, :cob => cob.upcase, :height => height.to_i}
		print "Now we have #{students.length} students\n"
		# get another student's details from the user
		puts "What is next student's name?"
		name = gets.chomp
		# run additional questions if another student is being added
		if name != ""
			puts "Which cohort is #{name} in?"
			cohort = gets.chomp
			puts "What are #{name}'s hobbies?"
			hobbies = gets.chomp
			puts "Which country was #{name} born in?"
			cob = gets.chomp
			puts "What is #{name}'s height in cm?"
			height = gets.chomp		
		end
	end
	# return the array of students
	students
end 

def print_header
  print "The students of my cohort at Makers Academy\n----------------\n"
end

# def print_student(students)
#   students.each.with_index(1) do |student, index|
#     puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)"
#   end
# end

# Rewriting above code using "while" control flow method
# def print_student(studentlist)
# 	count = 1
# 	while count <= studentlist.length 
# 		studentlist.select do |student|
# 			puts "#{count}. #{student[:name]} (#{student[:cohort]} cohort)"
# 			count += 1
# 		end
# 	end
# end

# Rewriting above code using "until" control flow method
def print_student(studentlist)
	count = 0
	until count >= studentlist.length 
		studentlist.select do |student|
			count += 1			
			puts "#{count}. #{student[:name]} (#{student[:cohort]} cohort)"
			puts "Hobbies: #{student[:hobbies]}, Birth country: #{student[:cob]}, Height: #{student[:height]}"
		end
	end
end

def print_footer(names)
  puts "Overall, we have #{names.length} great students"
end

# List only students whose name begins with a specified letter
def student_search(studentlist)
	puts "What is the starting letter you would like to search for?"
	# get the search character from user
	character = gets.chomp.capitalize
	puts "Names starting with #{character}:"
	# perform search for character
	studentlist.select do |student| 
		puts "#{student[:name]}" if student[:name].start_with?(character)
	end
end

# List only students with names shorter than specified number of characters
def students_namelength(studentlist)
	puts "What is the required maximum number of characters in full name?"
	# get number of characters from user
	namelength = gets.chomp.to_i
	puts "Names with up to #{namelength} characters:"
	# perform search for name lengths
	studentlist.select do |student|
		puts "#{student[:name]}" if student[:name].length <= namelength
	end
end	

students = input_students
print_header
print_student(students)
print_footer(students)
student_search(students)
students_namelength(students)