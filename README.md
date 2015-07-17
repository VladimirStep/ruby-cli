## The task

Build a standalone app that allows users to list their place via a
CLI. For the sake of simplicity, the data is kept locally. Similar to
the web app it should be possible to enter partial data and continue
later. However, make sure that in the end all required data is
present. Only when all data is present the newly created property
should appear in the list of all properties.

* Allow users to create new properties from the command line
* Prompt for attributes, validate the input
* When the data entry is interrupted, provide a way to resume entering data
* Store the property in some local storage; make sure no invalid data
  is stored
* Every property has the following attributes
  * title
  * property type, which is one of
    * holiday home
    * apartment
    * private room
  * address
  * nightly rate in EUR
  * max guests
  * email
  * phone number 

An example session could look like this:

    $ drkmen list
    No properties found.

    $ drkmen new
    Starting with new property ABC1DEF2.

    Title: Amazing room
    Address: ^C

    $ drkmen list
    No offers found.

    $ drkmen continue ABC1DEF2
    Continuing with ABC1DEF2

    Address: Voltastr. 5, 13355 Berlin
    Nightly rate in EUR: 12
    Max guests: Two

    Error: must be a number

    Max guests: 2
    ^C
    $ drkmen continue ABC1DEF2
    Continuing with ABC1DEF2

    Email: foo@example.com
    Phone number: +1 555 2368

    Great job! Listing ABC1DEF2 is complete!

    $ drkmen list
    Found 1 offer.

    ABC1DEF2: Amazing Room

## Hints

It's totally fine to use 3rd party libraries like ruby's gems. You're
free to choose your storage mechanism/database. Just use the right
tool for the job.

Expected time: 2 hours

Happy hacking!