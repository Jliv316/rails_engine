# Rails Engine

## Rails Engine on Your Local Machine

If you would like to run this application on your local machine, follow these steps. 

1. Fork this repository and clone the forked repository.
2. Once you have the forked repository cloned, navigate to the root directory of the application.
3. From the root directory of the application, run these two commands fpr the necessary gems:
```ruby
bundle install
bundle update
```
4. Set up the the database and seed the sales data.
```ruby
rake db:create
rake db:migrate

#seed the db with the command below
rake import:all
```

5. Once both of those commands have been run, you can run our test suite by running this command from the root directory:
```ruby
rspec
```
6.  We included the following gems in our project:
  - [Factory Bot](https://github.com/thoughtbot/factory_bot_rails)
  - [Faker](https://github.com/stympy/faker)
  - [Money](https://github.com/RubyMoney/money)
  - [Active Model Serializer](https://github.com/rails-api/active_model_serializers)
