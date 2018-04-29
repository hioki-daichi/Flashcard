ActiveRecord::Base.connection.execute <<~SQL
  INSERT INTO healths (time) VALUES (NOW());
  INSERT INTO users (login_name, created_at, updated_at) VALUES ('hioki-daichi', NOW(), NOW());
SQL

user_id = ActiveRecord::Base.connection.execute("SELECT currval('users_id_seq');").field_values('currval').first

1.upto(2).each do |i|
  ActiveRecord::Base.connection.execute <<~SQL
    INSERT INTO books (user_id, title, created_at, updated_at) VALUES (#{user_id}, 'Title #{i}', NOW(), NOW());
  SQL

  book_id = ActiveRecord::Base.connection.execute("SELECT currval('books_id_seq');").field_values('currval').first

  1.upto(5).each do |j|
    ActiveRecord::Base.connection.execute <<~SQL
      INSERT INTO pages (book_id, question, answer, created_at, updated_at) VALUES (#{book_id}, 'Question #{i}-#{j}', 'Answer #{i}-#{j}', NOW(), NOW());
    SQL
  end
end
