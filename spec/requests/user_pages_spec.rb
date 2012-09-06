require 'spec_helper'

describe "UserPages" do

	subject { page }

	describe "signup page" do
		before { visit signup_path }

		it { should have_selector('h1', text: "Sign up") }
		it { should have_selector('title', text: full_title('Sign up')) }
	end

	describe "Profile page" do
		#We use Factorygirl.create to create a new user
		let(:test_user) { FactoryGirl.create(:user) } #<~ The :user 
		# in the create should match the one in factory girl



		before { visit user_path(test_user) }

		it { should have_selector('h1', text: test_user.name ) }
		it { should have_selector('title', text: test_user.name) }
	end

	describe "signup" do
		#Filling name field - Submitting valid information and invalid

		before { visit signup_path }	
		let (:submit) { "Create my account" }

		describe "with invalid information" do

			it "should not create a user" do
				#This should not change the number of users in the db.
				# 3Coz it should fail 

				#Refactoring - Expect that clicking the button to not change the user
				#count. This is how you would do it in rspec. 
				expect { click_button submit }.not_to change(User, :count)

				#These four lines can be replaced with the above. 
				# old_count = User.count 
				# click_button submit 
				# new_count = User.count
				# new_count.should == old_count
			end

			describe "after submission" do
				before { click_button submit }

				it { should have_selector('title', text: 'Sign up') }
				it { should have_content('error') }
				it { should have_selector('div.alert.alert-error', text: "error") }
				it { should_not have_content('Password digest') }
			end

		end

		describe "with valid information" do

			#we want to fill in different fields with valid info
			before do
				fill_in "Name", 		with: "Maijid"
				fill_in "Email", 		with: "maijid@gmail.com"
				fill_in "Password", 	with: "password"
				fill_in "Confirmation", with: "password"
			end

			it "should create a user" do

				expect { click_button submit }.to change(User, :count).by(1)
				# old_count = User.count 
				# click_button submit
				# new_count = User.count
				# new_count.should == old_count + 1
			end

			describe "after saving a user " do	

				before { click_button submit }
				#Since we want to redirecto to the users profile after saving 
				#the user. We will determine if w'ere on that page by looking at the 
				#ittle of the page  (Which should be the name of the user)

				let (:user) { User.find_by_email("maijid@gmail.com") }
				it { should have_selector('title', text: user.name ) }
				it { should have_selector('div.alert.alert-success', text: 'Welcome') }
			end
		end
	end
end
