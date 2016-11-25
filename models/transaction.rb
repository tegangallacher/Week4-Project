 require_relative( '../db/sql_runner' )
require_relative( 'category' )
require_relative( 'merchant' )

class Transaction

  attr_reader( :merchant_id, :category_id, :id, :amount, :item )

  def initialize( options )
    @id = nil || options['id'].to_i
    @merchant_id = options['merchant_id']
    @category_id = options['category_id']
    @amount = options['amount'].to_i
    @item = options['item']
  end

  def save()
    sql = "INSERT INTO transactions (merchant_id, category_id, amount, item) VALUES (#{ @merchant_id }, #{ @category_id }, #{@amount}, '#{@item}') RETURNING *"
    results = SqlRunner.run(sql)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM transactions"
    results = SqlRunner.run( sql )
    return results.map { |hash| Transaction.new( hash ) }
  end

  def self.find( id )
    sql = "SELECT * FROM transactions WHERE id=#{id}"
    results = SqlRunner.run( sql )
    return Transaction.new( results.first )
  end

  def category()
    sql = "SELECT * FROM categories c
          INNER JOIN transactions t
          ON t.category_id = c.id
          WHERE c.id = #{@category_id}"
    results = SqlRunner.run( sql )
    return Category.new( results.first )
  end

  def merchant()
    sql = "SELECT * FROM merchants m
          INNER JOIN transactions t
          ON t.merchant_id = m.id
          WHERE m.id = #{@merchant_id}"
    results = SqlRunner.run( sql )
    return Merchant.new( results.first )
  end

  def self.delete_all()
    sql = "DELETE FROM transactions"
    SqlRunner.run( sql )
  end

  def self.destroy(id)
    sql = "DELETE FROM transactions where id = #{id}"
    SqlRunner.run( sql )
  end

  def self.update( options )
    sql = "UPDATE transactions SET
          merchant_id='#{options['merchant_id']}',
          category_id='#{options['category_id']}',
          item='#{options['item']}',
          amount='#{options['amount']}'
          WHERE id='#{options['id']}'"
    SqlRunner.run( sql )
  end


end
