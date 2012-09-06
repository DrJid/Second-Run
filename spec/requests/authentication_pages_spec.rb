require 'spec_helper'

describe "Authentication" do

	subject { page }

	describe "sign-in page" do	
		before { visit signin_path }

		it { should have_selector('title', text: 'Sign in') }
		it { should have_selector('h1', text: 'Sign in') }
	end

	describe "sign-in" do
		before { visit signin_path }

		# let(:submit) { "Sign in" }

		describe "with invalid credentials" do
			before { click_button "Sign in" }

			it { should have_selector('title', text: 'Sign in') }
			it { should have_selector('div.alert.alert-error', text: 'Invalid') }

			describe "after visiting another page" do
				before { click_link "Home" }
				it { should_not have_selector('div.alert.alert-error') }
			end
		end

		describe "with valid credentials" do	

			let(:user) { FactoryGirl.create(:user) }

			before do
				fill_in "Email", 	with: user.email
				fill_in "Password", with: user.password 
				click_button "Sign in"
			end

			it { should have_selector('title', text: user.name) }
			#using the have_link method to determine if it has the link!
			it { should have_link('Profile',	 href: user_path(user)) }
			it { should have_link('Sign out', 	 href: signout_path) }
			it { should_not have_link('Sign in', href: signin_path) }


			describe "followed by signout" do	
				before { click_link "Sign out" }
				it { should have_link('Sign in') }
				
			end
		end


	end

end
