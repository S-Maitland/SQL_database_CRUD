require('pg')

class Bounty

  attr_accessor :name, :homeworld, :danger_level, :bounty_value
  attr_reader :id

  def initialize(options)
    @name = options['name']
    @homeworld = options['homeworld']
    @danger_level = options['danger_level']
    @bounty_value = options['bounty_value'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    #connect to db
    db = PG.connect({dbname: 'bounties', host: 'localhost'})
    #creating sql statement to be prepared
    sql = "INSERT INTO bounties(
    name,
    homeworld,
    danger_level,
    bounty_value
  )
  VALUES ($1, $2, $3, $4)
  RETURNING id
  "
  #creating array to be used to avoid SQL injection attack
  values = [@name, @homeworld, @danger_level, @bounty_value]
  #run the prepared statement
  db.prepare('save', sql)
  #run as exec prepared with values and return the id assigned upon save.
  @id = db.exec_prepared('save', values)[0]['id'].to_i
  #closing the connection
  db.close()
end

def Bounty.all()
  #connect to db
  db = PG.connect({dbname: 'bounties', host: 'localhost'})
  #creating sql statement to be prepared
  sql = 'SELECT * FROM bounties'
  #run the prepared statement
  db.prepare('return_all', sql)
  #run as exec prepared with values and return the id assigned upon save.
  bounties = db.exec_prepared('return_all')
  #closing the connection
  db.close()
  return bounties.map {|bounty| Bounty.new(bounty)}
end

# update method to be able to update values within the database
def update()
  #connect to db
  db = PG.connect({dbname: 'bounties', host: 'localhost'})
  #creating sql statement to be prepared
  sql = 'update bounties
  SET(
    name,
    homeworld,
    danger_level,
    bounty_value
    ) =
    (
      $1, $2, $3, $4
    )
    WHERE id = $5
    '
    #creating array to be used to avoid SQL injection attack
    values = [@name, @homeworld, @danger_level, @bounty_value, @id]
    #run the prepared statement
    db.prepare('update', sql)
    #run as exec prepared with values and return the id assigned upon save.
    db.exec_prepared('update', values)
    #closing the connection
    db.close()
  end

  def delete()
    #create the connection to the db
    db = PG.connect({dbname: 'bounties', host: 'localhost'})
    # creating the sql statement
    sql = 'DELETE FROM bounties WHERE id = $1'
    # assign unique id number to valus
    values = [@id]
    #run the prepared statement
    db.prepare('delete', sql)
    #run the exec prepared statement
    db.exec_prepared('delete', values)
    #close the connection to the db
    db.close()
  end

  def Bounty.delete_all()
    #creat the connection to the db
    db = PG.connect({dbname: 'bounties', host: 'localhost'})
    # creating the sql statement
    sql = 'DELETE FROM bounties'
    #run the prepared statement
    db.prepare('delete_all', sql)
    #run the exec prepared statement
    bounties = db.exec_prepared('delete_all')
    #close the connection to the db
    db.close()
  end

  def Bounty.find_by_name(name)
    #creating a find method
    db = PG.connect({dbname: 'bounties', host: 'localhost'})

    #creating the sql statement
    sql = 'SELECT * FROM bounties WHERE name = $1'
    values =[name]
    #run the prepared statement
    db.prepare('find_by_name', sql)
    #run the prepared statement and return the found bounty
    result = db.exec_prepared('find_by_name', values)
    if (result.count() == 0)
      return nil
    else
      return Bounty.new(result[0])
    end
    #close the connection to the db
    db.close()
  end

end
