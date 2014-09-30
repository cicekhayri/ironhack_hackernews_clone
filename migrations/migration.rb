require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: '../default.db'
)


class Schema < ActiveRecord::Migration
  def change
    
    create_table :submits do |t|
      t.string :link
      t.string :text
      t.integer :points

      t.timestamps
    end 

    create_table :users do |t|
      t.string :username
      t.string :password
      add_reference :submits, :user, index: true

      t.timestamps
    end

    create_table :comments do |t|
      t.text :body
      t.references :submit
      add_reference :submits, :comment, index: true
      
      t.timestamps
    end

  end
end

Schema.new.change

