# spec/factories/logIn.rb

FactoryGirl.define do
	factory :newUser do
		username { Faker::Name.name }
		email { Faker::Internet.email }
		name { Faker::Name.name }
		birthdate { Faker::Date.backward(7300) }
		password { Faker::Internet.password }
		passwordConfirmation { Faker::Internet.password }
	end

	factory :memberLogin do
		email 'abc@gmail.com'
		password 'defghijk'
	end
end