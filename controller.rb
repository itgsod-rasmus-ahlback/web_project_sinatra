require 'sinatra'


class MainController
	def initialize
	end

	def find_text(search_term)
		Dir.glob("./public/text/*").each do |object|
			puts object
			if search_term == File.basename(object)
				return false
			end
		end
		return true
	end

	def find_pictures(search_term)
		checker = Dir.glob("./public/bilder/#{search_term}/*").each do |picture|
			return checker
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
	@broken = false
	erb :'index.html'
end

get '/:page' do
	if @@MainController.find_text(params[:page]) == false
		@bilder = 
		@paragraph = File.readlines("./public/text/#{params[:page]}")
		@param = params[:page]
	else
		@bilder = ["No pic"]
		@paragraph = File.readlines("./public/text/notfound")
		@param = false
	end
		erb :'page.html'
end

get '/bilder/:zon' do
	@get_pics = Dir.glob("./public/bilder/#{params[:zon]}/*.jpg")
	erb :'bilder.html', {:layout => :"bild_layout"}
end
