#rareshare_signin_spec.rb
#require '../'
require 'rails_helper'
require 'memberLogin'

describe "User logs in" do 
	before(:each) do
		visit "users/sign_in"
	end

	before(:all) do
		@memberLogin = FactoryGirl.build(:memberLogin)
		@invalidEmail = FactoryGirl.build(:memberLogin, :email => 'abcd@gmail.com')
		@invalidPassword = FactoryGirl.build(:memberLogin, :password => 'sdfdsfdf')
	end

	it "should display sign in form" do
		expect(page).to have_css 'form#new_user'
	end
	
	it "should successfully sign in when valid information is entered" do
		fill_in 'login-email', :with => @memberLogin.email
		fill_in 'login-password', :with => @memberLogin.password
		click_button 'Log In'
		expect(page).to have_link('Account')
	end

	it "should not sign in when empty values are entered" do
		click_button 'Log In'
		expect(current_path).to eq 'users/sign_in'
	end

	it "should not sign in when email id entered is invalid" do
		fill_in 'login-email', :with => @invalidEmail.email
		fill_in 'login-password', :with => @invalidEmail.password
		click_button 'Log In'
		expect(current_path).to eq 'users/sign_in'
	end

	it "should not sign in when password entered is invalid" do
		fill_in 'login-email', :with => @invalidPassword.email
		fill_in 'login-password', :with => @invalidPassword.password
		click_button 'Log In'
		expect(current_path).to eq 'users/sign_in'
		expect(page).to have_text("Invalid email or password.")
	end

	it "should redirect to signup page" do
		click_link('Sign up')
		expect(current_path).to eq '/users/sign_up'
	end

	it "should redirect to reset password page" do
		click_link('Reset password')
		expect(current_path).to eq '/users/password/new'
	end
end