namespace :db  do 
	desc "Fill database with sample data"
	task populate: :environment do 
		admin = User.create!(name: "Rake User", email: "example@railstutorial.org", 
							password: "foobar", 
							password_confirmation: "foobar")
		admin.toggle!(:admin)

		User.create!(name: "Syron Bowman", email: "syron.bowman@gmail.com",
						password: "syron232", 
						password_confirmation: "syron232").toggle!(:admin)

		User.create!(name: "Maijid Moujaled", email: "maijid@gmail.com",
							password: "mai232583",
							password_confirmation: "mai232583").toggle!(:admin)
		
		99.times do |n|
			name = Faker::Name.name 
			email = "example-#{n+1}@railstutorial.org"
			password = "password"
			User.create!(name: name, email: email, password: password,
				password_confirmation: password)
		end
	end
end