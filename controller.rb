require 'sinatra'

layout 'layout.erb'




@@files = Dir.glob("*/**.html.erb")

get '/test' do 
	"HEJ #{@@files}"
end



get '/' do
	erb :'index.html'
end

get '/teknisk_konsultverksamhet' do
	@test = 'teknisk_konsultverksamhet'
	erb :'teknisk_konsultverksamhet.html'
end

get '/specialresor' do
	@test = 'specialresor'
	erb :'specialresor.html'
end

get '/latindans' do
	@test = 'latindans'
	erb :'latindans.html'
end