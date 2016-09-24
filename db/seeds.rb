# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

vc_admin = User.create!(
  email: ENV['VC_ADMIN_EMAIL'],
  password: ENV['VC_ADMIN_PASSWORD'],
  password_confirmation: ENV['VC_ADMIN_PASSWORD'],
  first_name: 'VC',
  last_name: 'Admin'
)
vc_admin.add_role(:admin)

oo = Organization.create!(
    name: "Aldersgate United Methodist Church",
    description: "Church",
    url: "https://shareyourchristmas.net/partner/aldersgate/4"
)
vc_admin.add_role(:admin, oo)

admin_member = oo.memberships.create!(user: vc_admin, send_email: false)

guest = User.create!(
  email: ENV['USER_EMAIL'],
  password: ENV['USER_PASSWORD'],
  password_confirmation: ENV['USER_PASSWORD'],
  first_name: 'Joe',
  last_name: 'Generous'
)
normal_member = oo.memberships.create!(user: guest, send_email: true)

oo_admin = User.create!(
    email: ENV['ORG_ADMIN_EMAIL'],
    password: ENV['ORG_ADMIN_PASSWORD'],
    password_confirmation: ENV['ORG_ADMIN_PASSWORD'],
    first_name: 'Org',
    last_name: 'Admin'
)
oo_admin.add_role(:admin, oo)


cp = Campaign.create!(
  name: "Share Christmas 2016",
  donation_deadline: Date.today + 5.days,
  reminder_date: Date.today + 2.days,
  description: "Christmas campaign"
)
cp2 = Campaign.create!(
  name: "Backpacks 2016",
  donation_deadline: Date.today + 10.days,
  reminder_date: Date.today + 7.days,
  description: "Backpacks campaign"
)

oc = OrganizationCampaign.create!(organization: oo, campaign: cp)

sw = SocialWorker.create!(
  assigned_number: 10,
  last_name: "Kelly",
  first_name: "Charlie",
  email: "charlie@paddys.com",
  phone: "555-5555"
)
does = sw.recipient_families.create!(
  casenumber: 5,
  contact_last_name: "Jenkins",
  contact_first_name: "Leeroy",
  address: "33234 Something Ave",
  campaign: cp,
  city: "Seattle",
  state: "FL",
  zip: "24567",
  phone: "252-281-3348"
)

john = does.recipients.create!(
  first_name: "Jimmy",
  last_name: "Doe",
  age: 11,
  gender: "male",
  race: "Hispanic",
  size: "M",
  wish_list: "Bicycle, iPad Pro, Basketball"
)
jane = does.recipients.create!(
  first_name: "Jane",
  last_name: "Doe",
  age: 9,
  gender: "female",
  race: "Asian",
  size: "S",
  wish_list: "iPad Pro, legos"
)

