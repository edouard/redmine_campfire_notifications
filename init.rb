require 'redmine'
require_dependency 'notifier_hook'

Redmine::Plugin.register :redmine_campfire_notifications do
  name 'Redmine Campfire Notifications plugin'
  author 'Édouard Brière'
  description 'A plugin to display issue modifications to a Campfire room'
  version '0.0.2'
end
