# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

vc = VolunteerCenter.create(name: 'Durham, NC Volunteer Center')

vc_admin = User.create!(
  email: ENV['VC_ADMIN_EMAIL'],
  password: ENV['VC_ADMIN_PASSWORD'],
  password_confirmation: ENV['VC_ADMIN_PASSWORD'],
  first_name: 'VC',
  last_name: 'Admin'
)
vc_admin.add_role(:admin, vc)

oo = vc.organizations.create!(
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


cp = vc.campaigns.create!(
  name: "Share Christmas 2016",
  donation_deadline: Date.today + 5.days,
  reminder_date: Date.today + 2.days,
  description: "Christmas campaign"
)
cp2 = vc.campaigns.create!(
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
  city: "Seattle",
  state: "FL",
  zip: "24567",
  phone: "252-281-3348"
)

john = oc.recipients.create!(
  first_name: "Jimmy",
  last_name: "Doe",
  email: "jimmydoe@gmail.com",
  recipient_family: does,
  street: "Main Ave",
  city: "Springfield",
  state: "VA",
  zip_code: "22012",
  age: 11,
  gender: "male",
  race: "Hispanic",
  size: "M",
  wish_list: "Bicycle, iPad Pro, Basketball"
)
jane = oc.recipients.create!(
  first_name: "Jane",
  last_name: "Doe",
  email: "janedoe@gmail.com",
  recipient_family: does,
  street: "Second St",
  city: "Lava",
  state: "CO",
  zip_code: "80210",
  age: 9,
  gender: "female",
  race: "Asian",
  size: "S",
  wish_list: "iPad Pro, legos"
)

