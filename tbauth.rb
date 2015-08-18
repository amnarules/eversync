require 'rubygems'
require 'oauth'
require 'json' 
require 'tumblr_client'
require 'sanitize'

class TumblrAuth
	#contructor
	$client = "null"
	def initAuth()
		$client = Tumblr::Client.new({
  			:consumer_key =>'CONSUMER KEY',
	  		:consumer_secret =>'CONSUMER SECRET',
  			:oauth_token =>'OAUTH TOKEN',
  			:oauth_token_secret =>'OAUTH TOKEN SECRET'
		})
		
	end 
	# returns (quotes and text based) liked posts (for now)
	# photo sets are tricky and require a lot more formatting. 
	def getClientLikes()
		my_likes = Array.new
		cleaned_up = Array.new
		likes = $client.likes :limit => 20
		likes["liked_posts"].each do |like|
			if(like["type"] === "quote" || like["type" === "text"])
				my_likes.push(like["text"])
			end
		end
		my_likes
	end
	# cleans up the output from the tumblr api 
	# saves to some output .txt file
	def saveFile(filename)
		pretty = JSON.pretty_generate(filename)
		pretty_clean = Sanitize.clean(pretty)
		pretty_clean = pretty_clean.gsub(' \n', " <br/>" )
		pretty_clean = pretty_clean.gsub(',', " <br/> ")
		pretty_clean = pretty_clean.gsub('"', " <br/> ")

		File.open("output.txt", "w") do |f|
		f.write(pretty_clean)
	end
end
end





