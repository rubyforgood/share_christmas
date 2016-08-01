[![Build Status](https://travis-ci.org/rubyforgood/share_christmas.svg?branch=master)](https://travis-ci.org/rubyforgood/share_christmas)

# Share Your Holiday

It is an unfortunate reality that not every child has presents under their Christmas tree.
The amazing people at the [Durham, NC Volunteer Center](http://www.thevolunteercenter.org) have a program, [_Share Your Christmas_](http://www.thevolunteercenter.org/tp42/page.asp?ID=166190),
that matches needy families with donors who can put something special under their tree.
They need a new app to help them connect recipients and donors easily, and at scale.

Ideally, they would also like to have it generic enough to also work for Thanksgiving (turkeys)
and the start of the school year (backpacks full of school supplies for kids.)   Along these lines,
we're initially calling the project Share Your Holiday ... hopefully we'll think of a better name
along the way!

Even though their current manual process is extremely terrible, other cities have expressed interest
in this so this group will potentially be helping kids from all over the country!

For a problem statement including objectives, the current system, and a history see
[the wiki page Problem Statement](https://github.com/rubyforgood/share_christmas/wiki/Problem-Statement)

## Quick Start

You need:

- Ruby 2.2 or 2.3
- Rails 4.2.x
- Postgres 9.5 (May be changed by team later)
- PhantomJS (`brew install phantomjs` on macOS or [read instructions](https://github.com/teampoltergeist/poltergeist#installing-phantomjs))

Basically you need Git, Ruby and Rails.  If you have Git, Ruby and Postgres in some version
or another you're probably set.    But:

* If you're working on a virgin Windows machine,
you're best off going with the RailsInstaller at http://railsinstaller.org.
* If you have a virgin Mac OSX machine, just follow the directions in
https://gorails.com/setup/osx/10.11-el-capitan.


 Then from a command prompt:

```bash
$ git clone http://github.com/rubyforgood/share_christmas
$ cd share_christmas
$ bin/setup
$ rails s
```

Then navigate to `http://localhost:3000` in your browser to view the app. Two user accounts will be available for logging in: **User** and **Admin**. Use one of the logins to access the app:
 * User
   * Email: `user@example.com`
   * Password: `password`
 * Admin
   * Email: `admin@example.com`
   * Password: `password`

## Testing

We are using [RSpec](https://github.com/rspec/rspec-rails) for testing. You can
run the tests with

```
rspec
```
or by running the default rake task with

```
rake
```

We also use Rubocop to enforce a common style.  Our specific Rubocop rules are in `rubocopy.yml` for easy running.

## User Stories

As an admin of a Volunteer Center, I want to:
  - add a new organization
  - create a new campaign
  - manage all affiliated organizations
  - manage all affiliated campaigns

As an Organization Campaign Manager, I want to:
  - add a new donor an organization's campaign
  - add a new recipient to an organization's campaign
  - facilitate a match between a donor and a recipient

As an Individual Donor, I want to:
  - register for an organization's campaign
  - choose a potential recipient to sponsor
