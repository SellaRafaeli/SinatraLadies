require 'sinatra'
require 'erb'
require 'mongo'

#db
$mongo = Mongo::MongoClient.from_uri('mongodb://localhost:27017').db('rails_girls')
$tasks = $mongo.collection('tasks')

#functions
def view_tasks(tasks = nil)  
  erb :view, locals: {tasks: $tasks.find.to_a}
end

get '/' do
  view_tasks
end

post '/add' do
  $tasks.insert(params)  
  view_tasks
end

get '/clear_all' do
  $tasks.drop
  view_tasks
end