# Private Events 

This is the repository for a Rails app similar to Eventbrite. It is a project in Active Record Associations as part of The Odin Project [curriculum](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-on-rails/lessons/associations).

### Installation

- #### Step 1: Install Locally

  1. clone this repo
  2. cd into cloned directory `cd private-events`
  3. run `bundle install`

- #### Step 2: Seed the database

  1. `rails db:migrate`
  2. `rails db:seed`

- #### Step 3: Fire up Rails Server

  1. `rails server`
  2. Navigate to [localhost:3000](localhost:3000) in your browser

### Running the Tests

#### To run all the tests

- `rspec spec/` from the `private-events` directory.

#### To run specific spec categories

- `rspec spec/features`
- `rspec spec/models`
- `rspec spec/requests`

### Authentication and Login

- uses `bcrypt` and `has_secure_password` for authentication

### Active Record Associations

- many to many relationships
- `has_many, through:` relationships
- generate db migrations with proper foreign keys

### Active Record Queries

- use `scope` to limit records returned to a specific constraint
- use `includes` method to eager load records where appropriate
- use `joins` to join two tables together when necessary

#### Notable Gems used

- bcrypt
- bullet
- will_paginate
- guard
- guard-rspec
- shoulda-matchers
- factory_bot_rails
- faker
- simplecov
