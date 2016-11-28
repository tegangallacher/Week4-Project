require_relative( '../db/sql_runner' )
require('pry-byebug')
require_relative( 'transaction' )


class Category

  attr_reader( :tag, :id )

  def initialize( options )
    @id = nil || options['id'].to_i
    @tag = options['tag']
  end

  def save()
    sql = "INSERT INTO categories (tag) VALUES ('#{ @tag }') RETURNING *"
    results = SqlRunner.run(sql)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM categories"
    results = SqlRunner.run( sql )
    return results.map { |hash| Category.new( hash ) }
  end

  def self.find( id )
    sql = "SELECT * FROM categories WHERE id=#{id}"
    results = SqlRunner.run( sql )
    return Category.new( results.first )
  end

  def self.delete_all()
    sql = "DELETE FROM categories"
    SqlRunner.run( sql )
  end

  def self.destroy(id)
    sql = "DELETE FROM categories where id = #{id}"
    SqlRunner.run( sql )
  end

  def self.update( options )
    sql = "UPDATE categories SET
    tag='#{options['tag']}'
    WHERE id='#{options['id']}'"
    SqlRunner.run( sql )
  end

end
