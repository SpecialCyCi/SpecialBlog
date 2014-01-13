# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "Create Admin.."
email = "admin@admin.com"
password = "admin123456"
if Admin.find_or_create_by({ email: email, password: password})
  puts "-- Admin Email: #{email}"
  puts "-- Admin Password: #{password}"
else
  puts "-- Create failed!"
end

puts "Create me Profile..."
Setting.set("name", "Special")
Setting.set("email", "specialcyci@gmail.com")
Setting.set("avatar", 'http://en.gravatar.com/userimage/59056755/86307a3d148e8b0904ccdf8a0fa10f6c.jpg?size=200') 
Setting.set("age",  "21")
Setting.set("location", "SCAU GuangZhou")
Setting.set("profession", "Student")
Setting.set("description", "### Support for markdown!")

puts "Database seed finished."
