require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/merchant.rb' )

get '/merchants' do
  @merchants = Merchant.all()
  erb( :merchant_index )
end

get '/merchants/new' do
  @merchants = Merchant.all()
  erb(:merchant_new)
end

post '/merchants' do
  merchant = Merchant.new(params)
  merchant.save()
  redirect to('/merchants')
end

get '/merchants/:id/edit' do
  @merchant = Merchant.find( params[:id] )
  erb(:merchant_edit)
end

post '/merchants/:id' do
  Merchant.update( params )
  redirect to ("/merchants")
end