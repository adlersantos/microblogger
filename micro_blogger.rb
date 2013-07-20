require 'jumpstart_auth'
require 'bitly'

class MicroBlogger
	attr_reader :client

	def initialize
		puts "Initializing"
		@client = JumpstartAuth.twitter
		Bitly.use_api_version_3
		@bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
	end

	def dm(target, message)
		screen_names = @client.followers.collect { |follower| follower.screen_name }
		if screen_names.include?(target)
			puts "Trying to send #{target} this direct message:"
			puts message
		else
			puts "user doesn't exist"
		end
	end

	def everyones_last_tweet
		friends_list = @client.friends
		friends_list.sort_by! { |friend| friend.screen_name.downcase }
		friends_list.each do |friend|
			timestamp = friend.status.created_at if friend.status
			puts "username: #{friend.screen_name}"
			puts "#{friend.status.text} (#{timestamp.strftime("%A, %b %d")})" if friend.status
		end
	end

	def followers_list
		@client.followers.collect { |follower| follower.screen_name }
	end

	def run
    command = ""
    while command != "q"
    	puts "Enter command:"
    	input = gets.chomp
    	parts = input.split
    	command = parts[0]

    	case command
		  	when 'elt' then everyones_last_tweet
		  	when 'dm' then dm(parts[1], parts[2..-1].join(' '))
		  	when 'q' then puts "Goodbye!"
		  	when 'spam' then spam_my_followers(parts[1..-1].join(' '))
		  	when 't' then tweet(parts[1..-1].join(' '))
		  	when 'turl' then tweet("#{parts[1..-2]} #{shorten_url(parts[-1])}")
		  	else
		  		puts "Sorry, I don't know how to #{command}"
    	end
    end
	end

	def shorten_url(original_url)
		puts "Shortening the URL #{original_url}"
		shortened_url = @bitly.shorten(original_url).short_url
 		return shortened_url
	end

	def spam_my_followers(message)
		followers = followers_list
		followers.each do |follower|
			dm(follower, message)
		end
	end

	def tweet(message)
		if message.length <= 140
			@client.update(message)
		else
			puts "tweet is more than 140 characters"
		end
	end

end

if __FILE__ == $PROGRAM_NAME
	blogger = MicroBlogger.new
	blogger.run
end