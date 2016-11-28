require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/category.rb' )
require_relative( '../models/transaction.rb' )
require('pry-byebug')

get '/categories' do
  @categories = Category.all()
  erb( :category_index )
end

get '/categories/new' do
  @categories = Category.all()
  erb(:category_new)
end

post '/categories' do
  category = Category.new(params)
  category.save()
  redirect to('/categories')
end

# post '/categories/:id/delete' do
#   Category.destroy(params[:id])
#   redirect to ('/categories')
# end

get '/categories/:id' do
  @transactions = Transaction.transactions_by_category(params[:id])
  @total = Transaction.total_expenditure_by_category(params[:id])
  erb(:transaction_by_category)
end

post '/categories/:id/hi' do
  redirect to ("/categories/:id")
end 

get '/categories/:id/edit' do
  @category = Category.find( params[:id] )
  erb(:category_edit)
end

post '/categories/:id' do
  Category.update( params )
  redirect to ("/categories")
end 