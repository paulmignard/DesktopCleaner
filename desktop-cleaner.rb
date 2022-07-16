#Alright, ruby time!
require 'securerandom'

# Config 
$user = ENV["USER"]
$desktop_directory = "/users/" + $user + "/Desktop/"
$ideas_directory = "/users/" + $user + "/Documents/_ideas/"

# Counters
$file_count = 0

puts("Starting cleanup, let's do this! 💪🏻")

# Well, let's find some files!
Dir[$desktop_directory+"*"].each do |file_name|
    
    # Is this a directory? If so, NEXT
    next if File.directory? file_name 
    
    # Is this an iphone or mac screenshot?
    next if not file_name.include? "PNG image" and not file_name.include? "Screen Shot"

    # Great, if we're here we have a file that's *probably* an idea!
    $file_count += 1
    file_create_time = File.birthtime(file_name)
    new_file_name = "i-" + file_create_time.year.to_s + "-" + file_create_time.month.to_s + "-" + file_create_time.day.to_s + "-" + SecureRandom.uuid
    puts new_file_name

    # Alright, let's move it!
    # NOTE: This won't work across partitions on nix systems? 🤔
    File.rename file_name, $ideas_directory + new_file_name

  end

  # All Done!
  puts(" ")
  puts("All Done! 🥳")
  puts("Files Changed:          " + $file_count.to_s)
  puts(" ")

