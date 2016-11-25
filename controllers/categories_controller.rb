require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/category.rb' )

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

post '/categories/:id/delete' do
  Category.destroy(params[:id])
  redirect to ('/categories')
end