gem 'tinder'
require 'tinder'

class NotifierHook < Redmine::Hook::Listener

  def controller_issues_new_after_save(context = { })
    campfire_url = 'campfire_url'
    campfire_login = 'email@email.com'
    campfire_password = ''
    campfire_room = 'campfire_room'
    campfire = Tinder::Campfire.new campfire_url
    campfire.login campfire_login, campfire_password
    room = campfire.find_room_by_name(campfire_room)
    @project = context[:project]
    @issue = context[:issue]
    @user = @issue.author
    room.speak "#{@user.firstname} created issue ##{@issue.id}: “#{@issue.subject}”. “#{NotifierHook.truncate_words(@issue.description)}” http://url.to.redmine/issues/#{@issue.id}"
    
  end
  
  def controller_issues_edit_after_save(context = { })
    campfire_url = 'campfire_url'
    campfire_login = 'email@email.com'
    campfire_password = ''
    campfire_room = 'campfire_room'
    campfire = Tinder::Campfire.new campfire_url
    campfire.login campfire_login, campfire_password
    room = campfire.find_room_by_name(campfire_room)
    @project = context[:project]
    @issue = context[:issue]
    @journal = context[:journal]
    @user = @journal.user
    room.speak "#{@user.firstname} edited issue ##{@issue.id} (#{@issue.subject}): “#{NotifierHook.truncate_words(@journal.notes)}”. http://url.to.redmine/issues/#{@issue.id}"
  end
  
  def controller_board_message_new_after_save(context = { })
    campfire_url = 'campfire_url'
    campfire_login = 'email@email.com'
    campfire_password = ''
    campfire_room = 'campfire_room'
    campfire = Tinder::Campfire.new campfire_url
    campfire.login campfire_login, campfire_password
    room = campfire.find_room_by_name(campfire_room)
    @project = context[:project]
    @message = context[:message]
    @user = @message.author
    room.speak "#{@user.firstname} wrote a new message “#{@message.subject}” in #{@project.name}: “#{NotifierHook.truncate_words(@message.content)}”. http://url.to.redmine/boards/#{@message.board.id}/topics/#{@message.root.id}#message-#{@message.id}"
  end
  
  def controller_board_message_reply_after_save(context = { })
    campfire_url = 'campfire_url'
    campfire_login = 'email@email.com'
    campfire_password = ''
    campfire_room = 'campfire_room'
    campfire = Tinder::Campfire.new campfire_url
    campfire.login campfire_login, campfire_password
    room = campfire.find_room_by_name(campfire_room)
    @project = context[:project]
    @message = context[:message]
    @user = @message.author
    room.speak "#{@user.firstname} replied a message “#{@message.subject}” in #{@project.name}: “#{NotifierHook.truncate_words(@message.content)}”. http://url.to.redmine/boards/#{@message.board.id}/topics/#{@message.root.id}#message-#{@message.id}"
  end
  
  def controller_wiki_after_save(context = { })
    campfire_url = 'campfire_url'
    campfire_login = 'email@email.com'
    campfire_password = ''
    campfire_room = 'campfire_room'
    campfire = Tinder::Campfire.new campfire_url
    campfire.login campfire_login, campfire_password
    room = campfire.find_room_by_name(campfire_room)
    @project = context[:project]
    @page = context[:page]
    @user = @page.content.author
    room.speak "#{@user.firstname} edited the wiki “#{@page.pretty_title}” in #{@project.name}. http://url.to.redmine/projects/#{@project.identifier}/wiki/#{@page.title}"
  end
  
  def self.truncate_words(text, length = 20, end_string = '…')
    return if text == nil
    words = text.split()
    words[0..(length-1)].join(' ') + (words.length > length ? end_string : '')
  end
end
