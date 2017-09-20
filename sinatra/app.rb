require 'sinatra'

get "/" do
	erb :main, lyout: :layout
end

post "/receive" do
	file = File.open("#{params["filename"]}", 'w')
	#file.puts(params[1]["tempfile"])
	file.close
	
	p params
end
