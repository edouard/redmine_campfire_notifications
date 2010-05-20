Campfire Notifier for Redmine
=============================

A Redmine plugin to display activity notifications on Campfire.

I forked this project to add the following featured:

- Use Campfire api token instead of login/password.
- Moved the settings into a config/campfire.yml file.
- URL that gets generated uses the host name set within Redmine settings rather than hardcoded.

![Screenshot](http://media.tumblr.com/tumblr_ku4fmvVJTB1qz6hl3.png)

[Blog post demonstrating its awesomeness](http://atelierconvivialite.com/post/202630568)

Installation
------------

- You need Redmine 0.8.5 or above
- Make sure you have the Tinder gem by adding to config/additional_environment.rb:

`config.gem 'tinder'`

and then run:

`rake:gems:install`

- Install the plugin:

`git clone http://github.com/kamui/redmine_campfire_notifications.git vendor/plugins/redmine_campfire_notifications`

- copy campfire.yml.example into config/campfire.yml with your campfire settings

`cp vendor/plugins/redmine_campfire_notifications/config/campfire.yml.example config/campfire.yml`

To do
---------

- Create a plugin interface. Right now the campfire authentication is hard-coded in the plugin. Create a plugin controller + view so the user should be able to:
  - Set the campfire room parameters (url, login, password)
  - Set which project should talk on Campfire
