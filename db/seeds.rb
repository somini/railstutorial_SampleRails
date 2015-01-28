# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
password = "sowrdfishistoosmall"
User.create!(nick: "Example",
	     mail: "user@domain.tld",
	     password: password,
	     password_confirmation: password)

99.times do |n|
	User.create!(nick: Faker::Name.name,
		     mail: "user-#{n}@faker.fake",
		     password: password,
		     password_confirmation: password)
end
