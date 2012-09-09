class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    #We add the index on both of these because we want to acess them by who posted and time
    add_index :microposts, [:user_id, :created_at]
  end
end
