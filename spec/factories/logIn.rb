# spec/factories/logIn.rb

FactoryGirl.define do
	factory :newUser do
		username 'abc'
		email 'abc@gmail.com'
		name 'abc def'
		birthdate '01-02-2003'
		password 'defghijk'
		passwordConfirmation 'defghijk'
	end

	factory :memberLogin do
		email 'abc@gmail.com'
		password 'defghijk'
	end
end