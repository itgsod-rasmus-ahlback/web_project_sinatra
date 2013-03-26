require 'sinatra'


class MainController
	def initialize
	end

	def find_text(search_term)
		Dir.glob("./public/text/*").each do |object|
			if search_term == File.basename(object)
				return false
			end
		end
		return true
	end

	def find_pictures(search_term)
		checker = []
		Dir.glob("./public/bilder/#{search_term}/*").each do |picture|
			checker << picture
		end
		if checker.size >= 1
			return checker
		else
			return ["false"]
		end
	end

end

@@MainController = MainController.new


layout 'layout.erb'


not_found do
	@broken = true
	erb :'index.html'
end


@@files = Dir.glob("*/**.html.erb")

get '/test' do 
	"HEJ #{@@files}"
end


get '/' do
	@bilder = ["false"]
	@paragraph = File.readlines("./public/text/start")
	@param = "start"
	@cool_text = "cool_text"
	@page = ""
	erb :'page.html'
end

get '/:page' do
	@cool_text = "not_cool_text"
	if @@MainController.find_text(params[:page]) == false
		@bilder = @@MainController.find_pictures(params[:page])
		@paragraph = File.readlines("./public/text/#{params[:page]}")
		@param = params[:page]
	else
		@bilder = ["No pic"]
		@paragraph = File.readlines("./public/text/notfound")
		@param = false
	end
		@page = params[:page].downcase
		erb :'page.html'
end

get '/bilder/:zon' do
	@get_pics = Dir.glob("./public/bilder/#{params[:zon]}/*.jpg")
	erb :'bilder.html', {:layout => :"bild_layout"}
end