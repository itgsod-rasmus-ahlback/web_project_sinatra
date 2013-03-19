require 'sinatra'

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

get '/teknisk_konsultverksamhet' do
	@test = 'teknisk_konsultverksamhet'
	erb :'teknisk_konsultverksamhet.html'
end

get '/:page' do
	@test = 'specialresor'
	@bilder_specialresor = Dir.glob("./public/bilder/#{params[:page]}/*.jpg")
	@paragraph = File.readlines("./public/text/#{params[:page]}")
	erb :'specialresor.html'
end

get '/bilder/:zon' do
	@get_pics = Dir.glob("./public/bilder/#{params[:zon]}/*.jpg")
	erb :'bilder.html', {:layout => :"bild_layout"}
end


get '/latindans' do
	@test = 'latindans'
	@bilder_latindans = Dir.glob("./public/bilder/latindans/*")
	erb :'latindans.html'
end