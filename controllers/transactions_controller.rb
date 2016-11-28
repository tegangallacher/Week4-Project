require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/category.rb' )
require_relative( '../models/merchant.rb' )
require_relative( '../models/transaction.rb' )
require('pry-byebug')

get '/transactions' do
  @transactions = Transaction.all()
  @total = Transaction.total_expenditure
  erb( :index )
end


get '/transactions/new' do
  @categories = Category.all()
  @merchants = Merchant.all()
  erb(:new)
end

post '/transactions' do
  transaction = Transaction.new(params)
  transaction.save()
  redirect to('/transactions')
end

get '/transactions/:id' do
  @transaction = Transaction.find(params[:id])
  erb(:show)
end

post '/transactions/:id/delete' do
  Transaction.destroy(params[:id])
  redirect to ('/transactions')
end

get '/transactions/:id/edit' do
  @categories = Category.all()
  @merchants = Merchant.all()
  @transaction = Transaction.find( params[:id] )
  erb(:edit)
end

post '/transactions/:id' do
  Transaction.update( params )
  redirect to ("/transactions/#{params[:id]}")
end






