# Share Your Holiday 

It is an unfortunate reality that not every child has presents under their Christmas tree. 
The amazing people at the Durham, NC Volunteer Center have a program, _Share Your Christmas_, 
that matches needy families with donors who can put something special under their tree. 
They need a new app to help them connect recipients and donors easily, and at scale. 

Ideally they would also like to have it generic enough to also work for Thanksgiving (turkeys) 
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

Basically you need Git, Ruby and Rails.  If you have Git, Ruby and Postgres in some version
or another you're probably set.    But:

* If you're working on a virgin Windows machine,
you're best off going with the RailsInstaller at http://railsinstaller.org.  
* If you have a virgin Mac OSX machine, just follow the directions in 
https://gorails.com/setup/osx/10.11-el-capitan.  


 Then from a command prompt:

```
$ git clone http://github.com/rubyforgood/share_christmas
$ cd share_christmas
$ bundle install
$ rails db:create
$ rails server
```

Then hit http://localhost:3000 with your browser and off you go!  
