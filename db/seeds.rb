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

vc = VolunteerCenter.create(name: 'Durham, NC Volunteer Center')

oo = vc.organizations.create!(name: "Aldersgate United Methodist Church", description: "Church", url: "https://shareyourchristmas.net/partner/aldersgate/4")

cp = vc.campaigns.create!(name: "Share Christmas 2016", donation_deadline: Date.today + 5.days, reminder_date: Date.today + 2.days, description: "Christmas campaign")

oc = OrganizationCampaign.create!(organization: oo, campaign: cp)

10.times do |i|
  Recipient.create!(first_name: "John", last_name: "Doe", email: "JohnDoe#{i}@gmail.com", street: "Main Ave", city: "Springfield", state: "VA", zip_code: "22012", age: 25, gender: "male", race: "Hispanic", size: "M", wish_list: "Generic")
end
