require 'sinatra'
require_relative 'contact'
require_relative 'rolodex'

$rolodex = Rolodex.new # Set a global variable to allow acces from each action in Sinatra

# temp fake data
$rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))

# ===== ROUTES =====

get '/' do		# Root directory
	@crm_app_name = "My CRM"	# Instance variable containing application name that can be read by index.erb
	erb :index	# Refers to the main page, index.erb
end


# Refers to contacts.erb
get '/contacts' do
	erb :contacts
end

# Add a new contact
get '/contacts/new' do
	erb :new_contact
end

get "/contacts/1000" do
	@contact = $rolodex.find_contact(1000)
	erb :show_contact
end

# Server responds to the POST method and creates a resource
# with the data submitted from new_contact.erb
post '/contacts' do
	# puts params
	new_contact = Contact.new(params[:fname], params[:lname], params[:email], params[:notes])
	$rolodex.add_contact(new_contact)
	redirect to('/contacts')	# Redirects to display contacts page
end