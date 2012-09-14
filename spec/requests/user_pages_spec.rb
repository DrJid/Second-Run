require 'spec_helper'

describe "UserPages" do

	subject { page }


	describe "index" do
		
		let(:user) { FactoryGirl.create(:user) }

	
		before do
			sign_in user
			# FactoryGirl.create(:user, email: "index@grinnell.edu")
			# FactoryGirl.create(:user, name: "Bob", email:"bob@examp.com")
			# FactoryGirl.create(:user, name: "Ben", email:"ben@examp.com")
			30.times { FactoryGirl.create(:user) }
			visit users_path
		end

		it { should have_selector('title', text: "All users")}
		it { should have_selector('h1', text: 'All users')}

		it "should list each user" do
			User.paginate(page: 1).each do |user|
				page.should have_selector('li' , text:user.name)
			end
		end

		it { should have_selector('div.pagination') }
	end

	describe "signup page" do
		before { visit signup_path }

		it { should have_selector('h1', text: "Sign up") }
		it { should have_selector('title', text: full_title('Sign up')) }
	end

	describe "Profile page" do
		#We use Factorygirl.create to create a new user
		let(:test_user) { FactoryGirl.create(:user, email:"asdf@asdf.com") } #<~ The :user 
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
				fill_in "Name", 		with: "Kew"
				fill_in "Email", 		with: "kew@gmail.com"
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

			describe "after saving a user" do	

				before { click_button submit }
				#Since we want to redirecto to the users profile after saving 
				#the user. We will determine if w'ere on that page by looking at the 
				#ittle of the page  (Which should be the name of the user)

				let (:user) { User.find_by_email("kew@gmail.com") }
				it { should have_selector('title', text: user.name ) }
				it { should have_selector('div.alert.alert-success', text: 'Welcome') }
				it { should have_link('Sign out') }
			end
		end
	end

	describe "edit" do
		let(:user) { FactoryGirl.create(:user, email:"edit@grinnell.edu") }
		before do 
			sign_in user
			visit edit_user_path(user) 
		end

		describe "page" do

			it { should have_selector('h1', text: "Update") }
			it { should have_selector('title', text: user.name )}
			it { should have_link('Change', href: 'http://gravatar.com/emails') }

			describe "with invalid information" do
				before { click_button "Save Changes" }

				it { should have_content('error') }

			end

			describe "with valid information" do

				let(:new_name) { "New Name" }
				let(:new_email) { "asdfasdfsadfsadfmail@example.com" }

				before do
					fill_in "Name",	   		    with: new_name
					fill_in "Email", 		    with: new_email
					fill_in "Password" ,	    with: user.password
					fill_in "Confirm Password", with: user.password
					click_button "Save Changes"
				end

				#Why isn't it redirecting here in the test??!!!!!!!!!!!!!!!!!
				#TODO

				it { should have_selector('h1', text: new_name) }
				it { should have_link('Sign out', 	 href: signout_path) }
				it { should have_selector('div.alert.alert-success') }
				#Being more explicit about the name and email in the database. 
				#We can do that by calling a user.reload  +> It reloads from the d
				#Again, specify is used when we want to change the subject
				#from page to something else... 
				# 
				specify  { user.reload.name.should == new_name }
			    specify  { user.reload.email.should == new_email }
			end
		end
	end

	# describe "following/followers" do
	# 	let(:user) { FactoryGirl.create(:user) }
	# 	let(:other_user) { FactoryGirl.create(:user) }

	# 	before { user.follow!(other_user) }

	# 	describe "followed users (following)" do

	# 		before do
	# 			sign_in user
	# 			visit following_user_path
	# 		end
			
	# 		it { should have_selector('title', text: full_title('Following')) }
	# 		it { should have_selector('h3', text: 'Following') }
	# 		it { should have_link(other_user.name, href: user_path(other_user)) }
	# 	end

	# end
end
