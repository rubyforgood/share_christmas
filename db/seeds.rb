# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# TODO: change Default Admin info
u = User.create!(email: ENV['ADMIN_EMAIL'], password: ENV['ADMIN_PASSWORD'], password_confirmation: ENV['ADMIN_PASSWORD'])
u.add_role('volunteer_center_admin')

User.create!(email: ENV['USER_EMAIL'], password: ENV['USER_PASSWORD'], password_confirmation: ENV['USER_PASSWORD'])

VolunteerCenter.create(name: 'Durham, NC Volunteer Center')
