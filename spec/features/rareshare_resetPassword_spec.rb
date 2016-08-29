#rareshare_resetPassword_spec.rb

require 'rails_helper'
require 'memberLogin'

describe "User tries to reset password" do
	before(:each) do
		visit "users/password/new"
	end
	before(:all) do
		@memberLogin = FactoryGirl.build(:memberLogin)
		@invalidEmail = FactoryGirl.build(:memberLogin, :email => 'abcd@gmail.com')
		@invalidPassword = FactoryGirl.build(:memberLogin, :password => 'sdfdsfdf')
	end

	it "should successfully send reset password instructions" do
		fill_in 'user_email', :with => @memberLogin.email
		click_button 'Send me reset password instructions'
		expect(page).to have_text("")
	end

	it "should throw error on entering invalid email" do
		fill_in 'user_email', :with => @invalidEmail.email
		click_button 'Send me reset password instructions'
		expect(page).to have_text("Email not found")
	end

	it "should throw error when email is blank" do
		fill_in 'user_email', :with => ''
		click_button 'Send me reset password instructions'
		expect(page).to have_text("Email can't be blank")
	end

end