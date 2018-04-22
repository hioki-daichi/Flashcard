class CreateHealth < ActiveRecord::Migration[5.2]
  def change
    create_table :healths do |t|
      t.datetime :time, null: false
    end
  end
end
