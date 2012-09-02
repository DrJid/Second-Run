require 'spec_helper'

describe "Static pages" do

	describe "Home Page" do

		it "should have the content 'DrJid App'" do
			visit '/static_pages/home'
			page.should have_selector('h1', text: 'DrJid App')
			
		end

		it "should have the right title" do
			visit '/static_pages/home'
			page.should have_selector('title',
								text: "DrJid on Rails | Home")
		end
	end


	describe "Help Page" do
		
		it "should have the content help" do
			visit '/static_pages/help'
			page.should have_selector('h1', text: 'Help')
		end

		it "should have the right title" do
			visit '/static_pages/help'
			page.should have_selector('title',
								text: "DrJid on Rails | Help")
		end

	end

	describe "About Page" do
		
		it "should have the content 'About Us'" do
			visit '/static_pages/about'
			page.should have_selector('h1', text: 'About Us')
		end

		it "should have the right title" do
			visit '/static_pages/about'
			page.should have_selector('title',
								text: "DrJid on Rails | About")
		end
	end

end
