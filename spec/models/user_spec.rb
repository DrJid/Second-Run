require 'spec_helper'

describe User do
  # pending "add some examples to (or delete) #{__FILE__}"
  #Writing a pending test
  # it "should be a test"

  before  do 
   @user = User.new(name: "Example User", email: "user@example.com", 
  					password: "foobar", password_confirmation: "foobar") 
  end

  #Create a subject for this 
  subject { @user }
  # Now we can use "it"

#When ever there's aboolean, Rspec can help to to use it within the test.
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }

  #Has_secure_password creates these on the fly. They don't exist in the database.
  #Thus we need them to use has_secure_password
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }


  #Using boolean conventions for testing -- calls the valid?
  it { should be_valid }

  describe "when name is not present" do		
  	before { @user.name = " " }
  	it { should_not be_valid }
  end


  describe "when email is not present" do
  	before { @user.email = " " }
  	it { should_not be_valid }
  end

  describe "when name is too long" do
  	before { @user.name = "a"* 51 }
  	it { should_not be_valid }
  end

  describe "when email format is invalid" do
  	it "should be invalid" do
  		addresses = %w[user@foo,com user_atfoo.org example.user@foo.]
  		addresses.each do |invalid_address|
  			@user.email = invalid_address
  			@user.should_not be_valid
  		end
  	end
  end

  describe "when email format is valid" do
  	it "should be valid" do
  		addresses = %w[user@foo.COM A_US-ER@foo.com firs.las@foo.jp a+b@baz.cn]
  		addresses.each do |valid_address|
  			@user.email = valid_address
  			@user.should be_valid
  		end
  	end

  end

  describe "when email address is already taken" do
  	before do
  		user_with_same_email = @user.dup #Makes duplicate of user
  		user_with_same_email.email = @user.email.upcase
  		user_with_same_email.save
  	end

  	it { should_not be_valid }

  end

  describe "when password is not present" do
  	before { @user.password = @user.password_confirmation = ' ' }
  	it { should_not be_valid }
  end

  describe "when password doesn't match the confirmation" do
  	before { @user.password_confirmation = "mismatch" }
  	it { should_not be_valid }
  end

  describe "when password_confirmation is nil" do
  	before { @user.password_confirmation = nil }
  	it { should_not be_valid }
  end

  describe "when password length is too short" do
  	before { @user.password = @user.password_confirmation = "a" * 5 }
  	it { should_not be_valid }
  end

  describe "return value of authenticate" do
  	#Need to have user in the database. So we save this user
  	before { @user.save }

  	#user let to assign a variable in rspec
  	let(:found_user) { User.find_by_email(@user.email) }

  	describe "with valid password" do
  		it { should == found_user.authenticate(@user.password) }
  	end

  	describe "with invalid password" do

  		let(:user_for_invalid_password) { found_user.authenticate("invalid") }
  		# it { should_not == found_user.authenticate("invalid") } -- we will use the let above
  		#to make this more compact
  		it { should_not == user_for_invalid_password }

  		#To specify a property other than the subject(USER) you use specify
  		specify { user_for_invalid_password.should be_false }
  	end



  end


end
