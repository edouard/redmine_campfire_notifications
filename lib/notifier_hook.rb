gem 'tinder'
require 'tinder'

class NotifierHook < Redmine::Hook::Listener

  def controller_issues_new_after_save(context = { })
    @project = context[:project]
    @issue = context[:issue]
    @user = @issue.author
    speak "#{@user.firstname} created issue “#{@issue.subject}”. Comment: “#{truncate_words(@issue.description)}” http://bugs.atelierconvivialite.com/issues/#{@issue.id}"
  end
  
  def controller_issues_edit_after_save(context = { })
    @project = context[:project]
    @issue = context[:issue]
    @journal = context[:journal]
    @user = @journal.user
    speak "#{@user.firstname} edited issue “#{@issue.subject}”. Comment: “#{truncate_words(@journal.notes)}”. http://bugs.atelierconvivialite.com/issues/#{@issue.id}"
  end

  def controller_board_message_new_after_save(context = { })
    @project = context[:project]
    @message = context[:message]
    @user = @message.author
    speak "#{@user.firstname} wrote a new message “#{@message.subject}” on #{@project.name}: “#{truncate_words(@message.content)}”. http://bugs.atelierconvivialite.com/boards/#{@message.board.id}/topics/#{@message.root.id}#message-#{@message.id}"
  end
  
  def controller_board_message_reply_after_save(context = { })
    @project = context[:project]
    @message = context[:message]
    @user = @message.author
    speak "#{@user.firstname} replied a message “#{@message.subject}” on #{@project.name}: “#{truncate_words(@message.content)}”. http://bugs.atelierconvivialite.com/boards/#{@message.board.id}/topics/#{@message.root.id}#message-#{@message.id}"
  end
  
  def controller_wiki_after_save(context = { })
    @project = context[:project]
    @page = context[:page]
    @user = @page.content.author
    speak "#{@user.firstname} edited the wiki “#{@page.pretty_title}” on #{@project.name}. http://bugs.atelierconvivialite.com/projects/#{@project.identifier}/wiki/#{@page.title}"
  end

private
  def speak(message)
    campfire_url = 'campfire_url'
    campfire_login = 'email@email.com'
    campfire_password = ''
    campfire_room = 'campfire_room'
    campfire = Tinder::Campfire.new campfire_url
    campfire.login campfire_login, campfire_password
    room = campfire.find_room_by_name(campfire_room)
    room.speak message
  end

  def truncate_words(text, length = 20, end_string = '…')
    return if text == nil
    words = text.split()
    words[0..(length-1)].join(' ') + (words.length > length ? end_string : '')
  end
end
