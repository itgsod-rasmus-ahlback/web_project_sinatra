require 'sinatra'

# Code by Rasmus Ahlbäck

class MainController # class for getting data from files
	def initialize
	end

	def find_text(search_term) # find the text for the current page
		Dir.glob("./public/text/*").each do |object|
			if search_term == File.basename(object) #match text file with url
				return false
			end
		end
		return true
	end

	def find_pictures(search_term) #find pictures for the current page
		checker = []
		Dir.glob("./public/bilder/#{search_term}/*").each do |picture|
			checker << picture # add pictures from files into list
		end
		if checker.size >= 1
			return checker # only return list if there are pictures in it
		else
			return ["false"] # prevent error
		end
	end

end

@@MainController = MainController.new 


layout 'layout.erb'


not_found do # in case the page does not exists
	redirect '/hittade%20inte%20sidan'
end


get '/' do # get starting page
	@bilder = ["false"]
	@paragraph = File.readlines("./public/text/start")
	@param = "start"
	@cool_text = "cool_text" # centering text
	@page = ""
	erb :'page.html'
end

get '/:page' do # get all content pages based on url
	@cool_text = "not_cool_text"
	if @@MainController.find_text(params[:page]) == false
		@bilder = @@MainController.find_pictures(params[:page])
		@paragraph = File.readlines("./public/text/#{params[:page]}")
		@param = params[:page]
	else # if no page exists, display "not found text"
		@bilder = ["No pic"]
		@paragraph = File.readlines("./public/text/notfound")
		@param = false
	end
		@page = params[:page].downcase
		erb :'page.html'
end

get '/bilder/:zon' do # get pictures 
	@get_pics = Dir.glob("./public/bilder/#{params[:zon]}/*.jpg")
	erb :'bilder.html', {:layout => :"bild_layout"} # change layout to gallery layout
end