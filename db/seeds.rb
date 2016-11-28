require_relative( '../models/category.rb' )
require_relative( '../models/merchant.rb' )
require_relative( '../models/transaction.rb' )
require('pry-byebug')

Transaction.delete_all
Merchant.delete_all
Category.delete_all


merchant1 = Merchant.new({"name" => "Zara"})
merchant2 = Merchant.new({"name" => "Tesco"})
merchant3 = Merchant.new({"name" => "Starbucks"})

merchant1.save
merchant2.save
merchant3.save

category1 = Category.new({"tag" => "food"})
category2 = Category.new({"tag" => "clothes"})
category3 = Category.new({"tag" => "travel"})

category1.save
category2.save
category3.save

transaction1 = Transaction.new({
  "merchant_id" => merchant1.id,
  "category_id" => category2.id,
  "amount" => 30,
  "item" => "Jeans"
  })

transaction2 = Transaction.new({
  "merchant_id" => merchant3.id,
  "category_id" => category1.id,
  "amount" => 3,
  "item" => "Coffee"
  })

transaction1.save
transaction2.save



