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

Basically you need Git, Ruby and Rails.  If you have Rails 4.2, Ruby 2.1 and Git in some version,
you're all set.  But:

* If you're working on a virgin Windows machine,
you're best off going with the RailsInstaller at http://railsinstaller.org.  
* If you have a virgin Mac OSX machine, download https://github.com/tokaido/tokaidoapp/archive/master.zip,
drag the icon over to the Appications foler and run it.  


 Then from a command prompt:

    $ git clone http://github.com/rubyforgood/share_christmas
    $ cd share_christmas
    $ bundle install
    $ rails server

Then hit http://localhost:9000 with your browser and off you go!  
