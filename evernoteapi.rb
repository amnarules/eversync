# Load libraries 
require 'oauth'
require 'oauth/consumer'

# Load Thrift and Evernote Ruby libraries
require 'evernote_oauth'

class EvernoteAuth

	def initAuth()
		auth_token = "INSERT AUTH TOKEN HERE"
		sandbox = false 
		$client = EvernoteOAuth::Client.new(token: auth_token, sandbox: sandbox)
	end

	def getNote()
		note_store = $client.note_store
	end

	#creates note
	def make_note(note_store, note_title, note_body, parent_notebook = nil)
		n_body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
  		n_body += "<!DOCTYPE en-note SYSTEM \"http://xml.evernote.com/pub/enml2.dtd\">"
  		n_body += "<en-note>#{note_body}</en-note>"

  		our_note = Evernote::EDAM::Type::Note.new
  		our_note.title = note_title
  		our_note.content = n_body

  		begin 
  			note = note_store.createNote(our_note)
  		rescue Evernote::EDAM::Error::EDAMUserException => edue 
  			puts "EDAMUserException: #{edue}"
  		rescue Evernote::EDAM::Error::EDAMNotFoundException => ednfe
		    puts "EDAMNotFoundException: Invalid parent notebook GUID"
 		end
 		note
 	end
 end


