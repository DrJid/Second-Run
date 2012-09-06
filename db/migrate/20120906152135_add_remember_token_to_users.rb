class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :remember_token, :string

  	#We;re pulling users out of the database throught the remember_token. 
  	#So anytime, we are going to use find_byATRIBUTE. It's a good idea to 
  	# put an index on It
  	add_index :users, :remember_token
  end
end
