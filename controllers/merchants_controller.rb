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

post '/merchants/:id/delete' do
  Merchant.destroy(params[:id])
  redirect to ('/merchants')
end