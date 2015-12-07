require 'test_helper'

class ChefTest < ActiveSupport::TestCase

	def setup
		@chef = Chef.new(chefname: "John", email: "example@example.com")

	end

	test "chef should be valid" do
		assert @chef.valid?
	end

	test "chefname should be present" do
		@chef.chefname = " "
		assert_not @chef.valid?
	end

	test "chefname should not be too long" do
		@chef.chefname = "a" * 41
		assert_not @chef.valid?
	end

	test "chefname should not be too short" do
		@chef.chefname = "aa"
		assert_not @chef.valid?
	end

	test "email should be present" do
		@chef.email = " "
		assert_not @chef.valid?
	end

	test "email length should be within bounds" do
		@chef.email = "a" * 101 + "@example.com"
		assert_not @chef.valid?
	end

	test "email adress should be unique" do
		dup_chef = @chef.dup
		dup_chef.email = @chef.email.upcase
		@chef.save
		assert_not dup_chef.valid?
	end

	test "email validation should accept valid adress" do
		valid_adress = %w[user@eeee.com R_TDD-DS@eee.helo.org user@example.com first.last@eee.ua laurajoe@monk.cm]
		valid_adress.each do |va|
			@chef.email = va
			assert_not @chef.valid?, '#{va.inspect} should be valid'
		end
	end

	test "email validation should reject invalid adress" do
		invalid_adress = %w[oleg.com user@example,com user.name@example. fooo_@eeee+aar.com]
		invalid_adress.each do |ia|
			@chef.email = ia
			assert_not @chef.valid?, '#{ia.inspect} should be invalid'
		end
	end

end