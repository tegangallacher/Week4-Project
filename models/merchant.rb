require_relative( '../db/sql_runner' )

class Merchant

  attr_reader( :name, :id )

  def initialize( options )
    @id = nil || options['id'].to_i
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO merchants (name) VALUES ('#{ @name }') RETURNING *"
    results = SqlRunner.run(sql)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM merchants"
    results = SqlRunner.run( sql )
    return results.map { |hash| Merchant.new( hash ) }
  end

  def self.find( id )
    sql = "SELECT * FROM merchants WHERE id=#{id}"
    results = SqlRunner.run( sql )
    return Merchant.new( results.first )
  end

  def self.delete_all
    sql = "DELETE FROM merchants"
    SqlRunner.run( sql )
  end

  def self.destroy(id)
    sql = "DELETE FROM merchants where id = #{id}"
    SqlRunner.run( sql )
  end

  def self.update( options )
    sql = "UPDATE merchants SET
    name='#{options['name']}'
    WHERE id='#{options['id']}'"
    SqlRunner.run( sql )
  end


end
