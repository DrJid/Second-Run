
# Factory Girl similar to Rspec.

#This file is automatically include by Rspec.  

FactoryGirl.define do 
	# Given user, it automatically converts it to the user model. 
	factory :user do #This has to be user coz that's how factory girl knows that it's a 
		#user model
		sequence(:name) { |n| "Person #{n}" }
		sequence(:email) { |n| "person_#{n}@example.com" }
		# name "First Factory"
		# email "factory@maijid.com"
		password "password"
		password_confirmation "password"

		factory :admin do
			admin true
		end
	end
end