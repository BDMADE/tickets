# Tickets

This project is powered by Ruby on rails, Bootstrap framework.

# Installation Process
**_Unzip the folder_** and open terminal and write:
 
$ **cd tickets**

Install bundler : $ **gem install bundler**

Install tickets : $ **bundle install**

# Database Setup

Open `config-> database.yml` and **change in your Mysql database username and password**

**Database creation :** $ `bundle exec rake db:create`

**Database migrate :** $ `bundle exec rake db:migrate`

**Database seed :** $ `bundle exec rake db:seed`

# Run server
open terminal and run
$ `rails s`

# How it Works ?

Ticket is a simple support based system in where a `customer` can create a ticket for getting feedback from `agent`.

There are three type user in this system:
   1) Admin
   2) Agent
   3) Customer
   
**Admin** :    An `admin` can all works and manages all users, user types and can give also feedback to customer.
  Furthermore, an `admin` can see last month reports with all closed tickets and can download it's `pdf` report.
 
 **Agent** : An `agent` only can give feedback to `customer's` ticket. Also, he/she can view his/her profile and can change
 his password and other profile based information.
 
 **Customer** : A valid customer can create `ticket` and give feedback to `agent` comments. When ticket will be closed by an `agent`,
  customer can not give any reply for his/her closed ticket.

# Tools used
Ruby on Rails

Mysql

Bootstrap framework

AdminLTE themes

Jquery

Jquery Data table

RSpec

Capybara

# REST API
It has User, UserType and Ticket Rest API.

# License
Licensed under the MIT license