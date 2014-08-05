#let's put all students into an array
students = [
"Ruth Earle",
"Andy Gates",
"Marc Singh",
"Faisal Aydarus",
"Ethel Ng",
"Kevin Daniells",
"Maya Driver",
"Leopold Kwok",
"James McNeil",
"Jerome Pratt",
"David Wickes",
"Javier Silverio",
"Elliot Lewis",
"Ben Tillett",
"Vincent Koch",
"Michelle Ballard",
"Nick Roberts",
"Tatiana Soukiassian",
"Merve Silk",
"Albert Vallverdu",
"Lovis Schulze",
"Chris Oatley",
"Spike Lindsey",
"Henry Stanley"
]

def print_header
  puts "The students of my cohort at Makers Academy"
  puts "----------------"
end

def print(names)
  names.each do |name|
    puts name
  end
end

def print_footer(names)
  puts "Overall, we have #{names.length} great students"
end
#nothing happens until we call the methods
print_header
print(students)
print_footer(students)