# README

This application has 2 main models. Users and notes.

*Models*
User.rb has email, passowrd and name as attributes and has one to many relationship with notes.
Note.rb in turn has a many to one relationship with users with title, body and tag as attributes.

*Views*
As a user when you launch the application, you are directed to a screen to either log in or sign up.
After authenticating yourself, you have pages available to add, view and edit notes.

*Sessions*
Sessions help keep track of the user when logged in and keep track of it until they're logged out.
Session is stored in the cookie until it is destroyed when user logs out.

*Tests*
I have integrated Rspec for testing of the application.

*How to run?*
Clone the repository and inside the directory,
Run, $ bundle install
     $ bin/rails s
     
