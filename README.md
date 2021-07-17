# Medio

An innovative way to find and select a meeting location - created by [Daniel Mekuriaw](https://github.com/danielmekuriaw) and [Eten Utek](https://github.com/eten123).

This project is developed using Ruby, Rails, ActiveRecord, SQLite3, the Google Maps API and several other Ruby gems. For the sake of simplicity and due to the limited amount of time for development, it makes use of data from the **Faker** Ruby gem outside of accepting direct user inputs for user instances. This project is created as a phase 2 project for the Yale x Flatiron bootcamp by the two developers.

### Description

Making friends throughout the coronavirus pandemic has become increasingly difficult. Solve that issue by using Medio to build connections with nearby friends. No need to worry about where you'll meet. We'll take care of that.

### Goal
Our goal is to provide a simple yet powerful tool that helps people find places to meet with friends at the Medio (Spanis for halfway) mark between them.

### How it works
Medio allows users to select the type of place they would like to meet at, and through the use of the Google Maps API, it locates and suggests locations of the selected type whose distance from each user who are meeting is the least. In other words, it finds a midpoint location of a selected type between the locations of two different users (or it could also be two different locations) that minimizes the difference in the amount of time each user would have to travel to get to the meeting location.

### Gems


* **faker** - for generating random data
* **validates_timeliness** - for validating time for the date of birth time parameter
* **google_maps_service** - for working with the Google Maps API

* **geographiclib** - for using Geodesic functions (specially useful to find midpoints)

**NOTE:** *If you want to contribute to this project, make sure you are using the Rails 5.1.7 version (or at least specify this version when calling any of the rails generate commands). Using latest Rails versions may result conflicts, and so if you have a later version, you may have to call a deprecated rails version command. Use the command below to see which Rails version you have installed.*

```Ruby
rails --version
```

To call rails commands with a specific rails version, you can format your commands as:

```Ruby
rails _version_number_ action
```

In the case of the generate commands for this project, they would start like:

```Ruby
rails _5.1.7_ generate
```

The next step to work with this project is installing the required gems. This can be done with the following command:
```Ruby 
bundle install
```

In case you run onto an error while calling the command above, try installing each gem individually as follows:
```Ruby
gem install name_of_gem
```

### Running the Program
To run the website after cloning the repository, use the ```rails s ``` command to run it on a local server, and open this local host address through your browser to view what it looks like.

### File Structure
Medio-app
├── Gemfile

├── Gemfile.lock

├── README.md

├── Rakefile

├── app

│   ├── assets

│   │   ├── config

│   │   │   └── manifest.js

│   │   ├── images

│   │   ├── javascripts

│   │   │   ├── application.js

│   │   │   ├── cable.js

│   │   │   ├── channels

│   │   │   ├── locations.coffee

│   │   │   ├── preferences.coffee

│   │   │   ├── sessions.coffee

│   │   │   ├── user_preferences.coffee

│   │   │   └── users.coffee

│   │   └── stylesheets

│   │       ├── application.css

│   │       ├── locations.scss

│   │       ├── preferences.scss

│   │       ├── sessions.scss

│   │       ├── user_preferences.scss

│   │       └── users.scss

│   ├── channels

│   │   └── application_cable

│   │       ├── channel.rb

│   │       └── connection.rb

│   ├── controllers

│   │   ├── application_controller.rb

│   │   ├── concerns

│   │   ├── journeys_controller.rb

│   │   ├── sessions_controller.rb

│   │   └── users_controller.rb

│   ├── helpers

│   │   ├── application_helper.rb

│   │   ├── locations_helper.rb

│   │   ├── preferences_helper.rb

│   │   ├── sessions_helper.rb

│   │   ├── user_preferences_helper.rb

│   │   └── users_helper.rb

│   ├── jobs

│   │   └── application_job.rb

│   ├── mailers

│   │   └── application_mailer.rb

│   ├── models

│   │   ├── application_record.rb

│   │   ├── concerns

│   │   ├── friendship.rb

│   │   ├── journey.rb

│   │   ├── location.rb

│   │   ├── preference.rb

│   │   ├── user.rb

│   │   └── user_preference.rb

│   └── views

│       ├── errors

│       │   └── _errors.html.erb

│       ├── journeys

│       │   └── meet_view.html.erb

│       ├── layouts

│       │   ├── _nav.html.erb

│       │   ├── application.html.erb

│       │   ├── mailer.html.erb

│       │   └── mailer.text.erb

│       ├── sessions

│       │   └── new.html.erb

│       ├── shared

│       │   └── _navbar.html.erb

│       └── users

│           ├── aboutus.html.erb

│           ├── edit.html.erb

│           ├── followers.html.erb

│           ├── following.html.erb

│           ├── meet_view.html.erb

│           ├── new.html.erb

│           └── show.html.erb

├── bin

│   ├── bundle

│   ├── rails

│   ├── rake

│   ├── setup

│   ├── spring

│   ├── update

│   └── yarn

├── config

│   ├── application.rb

│   ├── boot.rb

│   ├── cable.yml

│   ├── database.yml

│   ├── environment.rb

│   ├── environments

│   │   ├── development.rb

│   │   ├── production.rb

│   │   └── test.rb

│   ├── initializers

│   │   ├── application_controller_renderer.rb

│   │   ├── assets.rb

│   │   ├── backtrace_silencers.rb

│   │   ├── cookies_serializer.rb

│   │   ├── filter_parameter_logging.rb

│   │   ├── inflections.rb

│   │   ├── mime_types.rb

│   │   ├── validates_timeliness.rb

│   │   └── wrap_parameters.rb

│   ├── locales

│   │   ├── en.yml

│   │   └── validates_timeliness.en.yml

│   ├── puma.rb

│   ├── routes.rb

│   ├── secrets.yml

│   └── spring.rb

├── config.ru

├── db

│   ├── development.sqlite3

│   ├── migrate

│   │   ├── 20210714061409_create_users.rb

│   │   ├── 20210714061429_create_preferences.rb

│   │   ├── 20210714061521_create_user_preferences.rb

│   │   ├── 20210714061554_create_locations.rb

│   │   ├── 20210714151237_create_friendship.rb

│   │   └── 20210715061033_create_journeys.rb

│   ├── schema.rb

│   └── seeds.rb

├── lib

│   ├── assets

│   └── tasks

├── log

│   └── development.log

├── package.json

├── public

│   ├── 404.html

│   ├── 422.html

│   ├── 500.html

│   ├── apple-touch-icon-precomposed.png

│   ├── apple-touch-icon.png

│   ├── favicon.ico

│   └── robots.txt

├── test

   ├── application_system_test_case.rb

   ├── controllers

   │   └── user_preferences_controller_test.rb

   ├── fixtures

   │   ├── files

   │   └── user_preferences.yml

   ├── helpers

   ├── integration

   ├── mailers

   ├── models

   │   └── user_preference_test.rb

   ├── system

   └── test_helper.rb

### Project Requirements

1. You should have at least five models. You do not have to have all of these built out on day one, but by the end of the week, you should have at least five models (Join tables count!).
Some methods in your models. There should be at least twenty methods total in your models. These are to be used to better extract data from your tables. If all of your logic is in your controller, you're making a mistake. Talk to an instructor if you're confused about the type of methods that might go on your models.

2. No APIs until you get approval from an instructor. If your app completely works with dummy data and you have time left over, you can ask an instructor if you can start working with an API.

3. An analytics page - The main learning goal of this is to get you to write some interesting ActiveRecord queries.

4. No JavaScript. Stay focused on Rails for this project - we'll have plenty of time to cover JS topics.
