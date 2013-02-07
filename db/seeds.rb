# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

p "Adding admin"
u = User.find_or_create_by_name({name: 'admin', email: 'admin@kiwitime.com', password: 'qwerty'})

u.add_role :admin
u.add_role :scrum_master
u.add_role :developer
u.add_role :approved