# Glasses

Glasses is a micro search framework to be used within Ruby web applications which utilize Active Record as a part of the middleware between the app's logic and database.
The gem's methods are placed inside controller methods 

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
However, a minimal set up is required. Also, please note that Glasses inserts raw SQL strings directly into ActiveRecord's ```ruby ModelName.where()``` method of the Base class, so make sure you are protected against SQL injection attacks before launching it on a production environment. If you are a beginner web dev, take a look [here](http://guides.rubyonrails.org/security.html#sql-injection) for some basic security understanding. If you are still insecure, keep reading as Glasses has a method with pre-built parameters sanitizing in case you are looking for a quick fix.

The examples below are made using Rails as the environment.

First, let's set up a controller method:
```ruby
def index
  if params[:search]
    @messages = Glasses.search(Message,params[:search])
  else
    @messages = Message.all
  end
end
```
Or, if you want to sanitize your input before searching, replace
```ruby
@messages = Glasses.sanitized_search(Message,params[:search])
```
by
```ruby
@messages = Glasses.search(Message,params[:search])
```


This method should of course be serving as an interface between
the application's DB and user's input through a search form
(both forms are given here because I've had problems building
my first one, consider it as a gift):
```html
<%= form_for(:search, url: messages_path, method: "get") do |f| %>
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

Too simple? The same method can also be used with an advanced search form
like the one below:

```html
<%= form_for(:search, url: portfolio_path, method: "get") do |f| %>
  Select by:

  <%= f.label :job_name, "Job: " %>
  <%= f.text_field :job_name %></br>

  <%= f.label :category_id, "Category: " %>
  <%= f.collection_select :category_id, @categories, :id, :name, include_blank: "All"  %></br>

  <%= f.submit "Search with criteria" %>
  <% end %>
```
The algorithm differentiates between id and text search input,
so no trouble at all.

The method's output will be an array of instances of the class
passed in the first parameter. The second parameter should be a
hash with the fields and values to be searched inside that specific
relation represented by the class that goes in the first parameter
(probably the parameters hash, but could be any).

That's about it. Source code is located in lib/glasses.rb , more info
about each specific method below.

## Usage

All of the methods below return an array of objects of the
relation passed as the first parameter. The main difference
between them is that some offer a more optimized search for
each search form's input (say, let's suppose your parameter is
the id for some object; different than searching for a specific
string prefix).
The '.search' method is used in a lazy way, as it
works with the commonplace search types.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/glasses/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
