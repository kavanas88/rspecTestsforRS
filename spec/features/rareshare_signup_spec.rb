#rareshare_signup_spec.rb

#require '../'
require 'rails_helper'
require 'newUser'

describe "User signs up" do 

	before(:all) do 
		@user = FactoryGirl.build(:newUser)
		@invalidEmail = FactoryGirl.build(:newUser, :email => 'abc')
		@shortPassword = FactoryGirl.build(:newUser, :password => 'jklm')
		@invalidDate = FactoryGirl.build(:newUser, :birthdate => '02/31/2013')
		@passwordMismatch = FactoryGirl.build(:newUser, :password => 'jklmnopq', :passwordConfirmation => 'lmnopfde')
	end

	before(:each) do
		visit "users/sign_up" 
	end
	
	it "should display sign up form" do
			expect(page).to have_css 'form#new_user'
	end

	it "should create a user when valid information is entered" do
		fill_in 'user_username', :with => @user.username
		fill_in 'user_email', :with => @user.email
		fill_in 'user_name', :with => @user.name
		fill_in 'user_birthdate', :with => @user.birthdate
		fill_in 'user_password', :with => @user.password
		fill_in 'user_password_confirmation', :with => @user.passwordConfirmation
		click_button 'Sign up'
		expect(page).to have_link('Account')
	end

	it "should not create a user when empty values entered" do
		click_button 'Sign up'
		expect(page).to have_text("Username can't be blank")
		expect(page).to have_text("Email can't be blank")
		expect(page).to have_text("Password can't be blank")
	end

	it "should not create a user when invalid email is entered" do
		fill_in 'user_email', :with => @invalidEmail.email
		click_button 'Sign up'
		expect(current_path).to eq 'users/sign_up'
	end

	it "should not create a user when password is too short" do
		fill_in 'user_password', :with => @shortPassword.password
		click_button 'Sign up'
		expect(page).to have_content("Password is too short")
	end

	it "should not create a user when invalid date is entered" do
		fill_in 'user_birthdate', :with => @invalidDate.birthdate
		click_button 'Sign up'
		expect(current_path).to eq 'users/sign_up'
	end

	it "should not create a user when passwords dont match" do
		fill_in 'user_password', :with => @passwordMismatch.password
		fill_in 'user_password_confirmation', :with => @passwordMismatch.passwordConfirmation
		click_button 'Sign up'
		expect(page).to have_content("Password confirmation doesn't match Password")
	end

	it "should not create a user when invalid email is entered" do
		fill_in 'user_email', :with => @invalidEmail.email
		click_button 'Sign up'
		expect(current_path).to eq 'users/sign_up'
	end

	it "should redirect to log in page" do
		click_link('Log in')
		expect(current_path).to eq 'users/sign_in'
	end

	it "should redirect to sign up page" do
		click_link('Sign up')
		expect(current_path).to eq 'users/sign_up'
	end

	it "should redirect to forgot password page" do
		click_link('Forgot your password?')
		expect(current_path).to eq '/users/password/new'
	end
end