require 'rubygems'
require 'sinatra'

get '/' do
	files_unsolved = Dir.glob("./public/unsolved/*")
	status_unsolved = []
	
	0.upto(files_unsolved.length - 1) do |idx|
		status_unsolved << File.stat(files_unsolved[idx]).mtime
		files_unsolved[idx].slice!("./public/unsolved/")
	end

	joint = [files_unsolved, status_unsolved].transpose.to_h.sort_by{|k, v| v}.transpose
	
	@files_unsolved = joint[0].reverse
	@status_unsolved = joint[1].reverse
	
	files_solved = Dir.glob("./public/solved/*")
	status_solved = []
	
	0.upto(files_solved.length - 1) do |idx|
		status_solved << File.stat(files_solved[idx]).mtime
		files_solved[idx].slice!("./public/solved/")
	end

	joint = [files_solved, status_solved].transpose.to_h.sort_by{|k, v| v}.transpose
	
	@files_solved = joint[0].reverse
	@status_solved = joint[1].reverse

	erb :main, layout: :layout
end

post '/receive' do
	if(params["upFiles"])

		file = File.open("./public/#{params["directory"]}/#{params["upFiles"]["filename"]}", 'w')

		params["upFiles"]["tempfile"].each do |line|
			file.puts(line)
		end

		file.close
	end
	
	#params
	
	redirect '/'
end

