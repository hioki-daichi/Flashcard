class CreateSomeTables < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :login_name, index: true, null: false

      t.timestamps index: false, null: false
    end

    create_table :books do |t|
      t.references :user, index: true,  null: false, foreign_key: true
      t.string :title,    index: false, null: false

      t.timestamps index: false, null: false

      t.index [:user_id, :title], unique: true
    end

    create_table :pages do |t|
      t.references :book, index: true,  null: false, foreign_key: true
      t.text :question,   index: false, null: false
      t.text :answer,     index: false, null: false

      t.timestamps index: false, null: false
    end
  end
end
