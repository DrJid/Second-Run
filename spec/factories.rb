
# Factory Girl similar to Rspec.

#This file is automatically include by Rspec.  

FactoryGirl.define do 
	# Given user, it automatically converts it to the user model. 
	factory :user do #This has to be user coz that's how factory girl knows that it's a 
		#user model
		name "Maijid Moujaled"
		email "maijid@gmail.com"
		password "password"
		password_confirmation "password"
	end
end