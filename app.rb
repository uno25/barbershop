#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pony'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end
get '/about' do
	@error = "Error"
	erb :about 
end
get '/contacts' do
	erb :contacts 
end
post '/contacts' do
	@contactsname = params[:contactsname]
	@contactstext = params[:contactstext]
	contacts = File.open 'public/contacts.txt', 'a'
	contacts.write "#{@contactsname} - #{@contactstext} <br>"
	contacts.close
	require 'pony'
     Pony.mail(:to => 'unopuno@gmail.com', :from => "loco@loco.by",
    :subject => "inquiry from #{@contactsname}", :body => "#{@contactstext}",
    :via => :smtp)

     
	erb "#{@contactsname} - #{@contactstext} <br>"
end

get '/visit' do
	erb :visit 
end

post '/visit' do

	@name = params[:exampleInputEmail1]
	@time = params[:exampleTime]
	@barber = params[:barber]

hh = {:exampleInputEmail1 => 'Enter name', 
	:exampleTime => 'Enter date'}

@error = hh.select {|key,value| params[key]==''}.values.join (" ,")


if @error == nil
	@visits = File.open 'public/visits.txt', 'a'
	@visits.write "#{@name} - #{@time} - #{@barber} \n<br>"
	@visits.close

end	
erb :visit
	
end

get '/checkvisit' do
	erb :checkvisit 
end

post '/checkvisit' do
	@adminname = params[:adminname]
	@adminpass = params[:adminpass]
	if @adminname == 'admin' && @adminpass == 'secret' 
	visitsread = File.open 'public/visits.txt', 'r'
	@readvisits = visitsread.read
	visitsread.close
	end
	erb :checkvisit 
end


