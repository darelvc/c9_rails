require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
	def setup
		@chef = Chef.create(chefname: "Bob", email: "bob@example.com")
		@recipe = @chef.recipes.build(name: "chicken parm", summary: "This is the best chicken parm recipe ever", description: "This is the best chicken parm recipe ever")
	end

	test "recipe should be valid" do 
		assert @recipe.valid?
	end

	test "chef id must be present" do
		@recipe.chef_id = nil
		assert_not @recipe.valid?
	end

	test "name should be present" do 
		@recipe.name = " "
		assert_not @recipe.valid?
	end

	test "name length should be too long" do
		@recipe.name = "a" * 101
		assert_not @recipe.valid?
	end

	test "name length should not be too long" do
		@recipe.name = "aaaa"
		assert_not @recipe.valid?
	end

	test "summary should be present" do
		@recipe.summary = " "
		assert_not @recipe.valid?
	end

	test "summary length should not be long" do
		@recipe.summary = "a" * 151
		assert_not @recipe.valid?
	end

	test "summary length should not be short" do
		@recipe.summary = "a" * 9
		assert_not @recipe.valid?
	end

	test "description must be present" do
		@recipe.description = " "
		assert_not @recipe.valid?
	end

	test "description should not be too long" do
		@recipe.description = "a" * 501
		assert_not @recipe.valid?
	end

	test "description should not be too short" do
		@recipe.description = "a" * 19
		assert_not @recipe.valid?
	end
end