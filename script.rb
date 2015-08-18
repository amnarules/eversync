require './tbauth'
require './evernoteapi'

# this is where the magic happens

# tumblr pulls likes from the account
tauth = TumblrAuth.new()

tauth.initAuth()
tauth.saveFile(tauth.getClientLikes())

# evernote saves the file as a new evernote post 
# note: figure out a way to add tags to a new post 
ea = EvernoteAuth.new()
ea.initAuth()
ea.make_note($client.note_store, "Tumblr Likes", File.read('output.txt'), nil)