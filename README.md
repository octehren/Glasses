# Glasses
[![Gem Version](https://badge.fury.io/rb/glasses.svg)](http://badge.fury.io/rb/glasses) [![Build Status](https://travis-ci.org/otamm/Glasses.svg?branch=master)](https://travis-ci.org/otamm/Glasses)

Glasses is a micro search framework to be used within Ruby web applications which utilize Active Record as a part of the middleware between the app's logic and database.
The gem's methods are based upon ActiveRecord's querying methods, so you can consider them to be Database agnostic, at least in an environment using a relational system such as SQLite, PostgreSQL or MySQL; the gem have not been tested in a NoSQL system such as MongoDB and its functioning cannot be guaranteed in this kind of environment.
Also, the parameters are sanitized by ActiveRecord itself, so the search will be SQL-Injection-protected by default.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'glasses'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install glasses

## Set Up
This gem is intended to provide a quick way to enable searching in an app.
However, a minimal set up is required. Also, please note that Glasses inserts raw SQL strings directly into ActiveRecord's ```ModelName.where()``` method of the Base class, so make sure you are protected against SQL injection attacks before launching it on a production environment; a sanitizing 'before_filter' for the controller method which will be using Glasses should suffice.

If you are a beginner web dev, take a look [here](http://guides.rubyonrails.org/security.html#sql-injection) for some basic security understanding. If you are still insecure, keep reading as Glasses has a method with pre-built parameters sanitizing in case you are looking for a quick fix.

The examples below use Rails as the example environment.

First, let's set up a controller method:

```ruby
def search_message
  if params[:search]
    @messages = Glasses.search(Message,params[:search])
  else
    @messages = []
  end
end
```

And also add a route which uses the HTTP method GET:

```ruby
# located in your_rails_app/config/routes.rb
get 'search_for_a_message' => 'messages#search_message'
```

## Usage

This method should of course be serving as an interface between
the application's DB and user's input through a search form
(both forms are given here because I've had problems building
my first one, consider it as a gift):

```html
<%= form_for(:search, url: search_message_path, method: "get") do |f| %>
  <h2>Search Messages</h2></br>

  <%= f.label :name, "From: " %></br>
  <%= f.text_field :name %></br>

  <%= f.label :email, "Sender's Email: " %></br>
  <%= f.email_field :email %></br>

  <%= f.label :subject, "Subject: " %></br>
  <%= f.text_field :subject %></br>

  <%= f.label :body, "Text body: " %></br>
  <%= f.text_area :body %></br>

  <%= f.submit "Search Messages" %>
<% end %>
```

The method's output will be an array of instances of the class
passed in the first parameter. The second parameter should be a
hash with the fields and values to be searched inside that specific
relation represented by the class that goes in the first parameter
(probably the parameters hash, but could be any).

Is the form above too trivial? The same method can also be used with an advanced search form
like the one below:

```html
<%= form_for(:search, url: search_portfolio_path, method: "get") do |f| %>
  Select by:

  <%= f.label :job_name, "Job: " %>
  <%= f.text_field :job_name %></br>

  <%= f.label :category_id, "Category: " %>
  <%= f.collection_select :category_id, @categories, :id, :name, include_blank: "All"  %></br>

  <%= f.label "Look for award-winning jobs only" %>
  <%= f.check_box :is_award_winning_bool %>

  <%= f.submit "Search with criteria" %>
  <% end %>
```

The algorithm differentiates between ids, booleans and raw text search input types,
so no trouble at all. However, this differentiation needs some really basic specifications.

## Paremeter Constraints
Did you notice that the parameter being passed with the checkbox has its symbol ending with ```ruby "_bool" ```?
Well, actually the column being searched on is named ```ruby "is_award_winning" ```, not ```ruby "is_award_winning_bool" ```.
The suffix ```ruby "_bool" ``` is added only in the form so Glasses can detect that it should be searching for a boolean. Also, pass the value ```ruby "1" ``` for a checked box to represent the value ```ruby true ``` . Any number can be used when passing an id.

Glasses realizes what is the specific data type it should be looking for according to the suffix of the field being passed as one of the keys in the 'params' hash.

The only two other constraints are ```ruby "_min" ``` and ```ruby "_max" ``` as suffixes in range searches. However, to make a range search, the correct method to be utilized is ```ruby Glasses.search_range() ``` , not ```ruby Glasses.search() ```.

####Example:

```ruby
def search_user
  if params[:search]
    @users = Glasses.search_range(Message,params[:search])
  else
    @users = []
  end
end
```

```html
<%= form_for(:search, url: search_user_path, method: "get") do |f| %>

  Select by:</br>

  <%= f.label :first_name, "First Name: " %>
  <%= f.text_field :first_name %></br>

  <%= f.label :last_name, "Last Name: " %>
  <%= f.text_field :last_name %></br>

  <%= f.label :age_min, "Minimum Age: " %>
  <%= f.text_field :age_min %></br>

  <%= f.label :age_max, "Maximum Age: " %>
  <%= f.text_field :age_max %></br>

  <label>Look for admin users only: <!-- experience taught me not to trust helper methods when it comes to checkboxes or radio buttons. -->
      <input checked="checked" type="checkbox" id="checked_box" name="search_params[is_virgin_bool]" value="1" />
  </label>

  <%= f.submit "Search with criteria" %>

<% end %>
```

Done! Now that's a form which will return all the users who fit in the specified criteria which includes a string, a boolean and a range parameter.

## Contributing

That's about it. For further info on each gem method best fit for each specific scenarion, check the (soon to debut) gem's wiki. 
Source code is located in lib/glasses.rb; if you want to run tests locally, clone this repository and run ``` $bundle exec rake spec``` in the root project's directory in your terminal.

1. Fork it ( https://github.com/[my-github-username]/glasses/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
