ActiveRecord::Base.connection.execute 'INSERT INTO healths (time) values (NOW());'
