require 'spec_helper'

describe "Static pages" do

	# let(:base_title) { "DrJid on Rails" } #Using let makes us create a variable to use

	subject { page }

	describe "Home Page" do
		before { visit root_path } #Eliminates the need to type visit root_path all the time

		it { should have_selector('h1', text: "DrJid App") }


		# it { should have_selector('title', text: "#{base_title}") }
		# it { should_not have_selector('h2', text: " | Home") }

		it { should have_selector('title', text: full_title('')) }


		it { should have_selector('h2', text: "DrJid") }



		# I am leaving these comments here as a note to myself: Above shortens below
		# it "should have the h1 'DrJid App'" do
		# 	page.should have_selector('h1', text: 'DrJid App')			
		# end

		# it "should have the base title" do
		# 	page.should have_selector('title', text: "#{base_title}")
		# end

		# it "should not have a custom page title" do
		# 	page.should_not have_selector('title', text: " | Home")
		# end

		# it "should have the name 'DrJid'" do
		# 	page.should have_selector('h2', text: "DrJid")
		# end

	end


	describe "Help Page" do
		before { visit help_path }
		
		it { should have_selector('h1', text: 'Help') } 
		it { should have_selector('title', text: full_title('Help')) }


		# it "should have the content help" do
		# 	visit help_path
		# 	page.should have_selector('h1', text: 'Help')
		# end

		# it "should have the right title" do
		# 	visit help_path
		# 	page.should have_selector('title',
		# 						text: "#{base_title} | Help")
		# end

	end

	describe "About Page" do
		before { visit about_path }

		it { should have_selector('h1', text: 'About Us') }
		it { should have_selector('title', text: full_title("About")) }

	end

	describe "Contact Page" do
		before { visit contact_path }

		it { should have_selector('h1', text: "Contact") }
		it { should have_selector('title', text: full_title("Contact")) }
	end

	it "should have the right links on the layout" do 
		visit root_path

		click_link "Sign in"
		page.should have_selector('title', text: full_title('Sign in'))

		click_link "About"
		page.should have_selector('title', text: full_title("About"))

		click_link "Help"
		page.should have_selector('title', text: full_title('Help'))

		click_link "Contact"
		page.should have_selector('title', text: full_title('Contact'))

		click_link "Home"
		click_link "Sign up now!"
		page.should have_selector('title', text: full_title('Sign up'))

	end
end
