require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  
  #first creat an object of the model you want to test and asighn it to an instance variable
  def setup
    @chef = Chef.create(chefname: "christ", email: "christ@makedish.com")
    @recipe = @chef.recipes.build(name: "chicken parm", summary: "This is the best recipe ever", description: "heat oil, add onion,
    add tomatos source, add chicken, cook for 20 mins")
  end
  
  #then start writing your test like this is first test says there should be a valid recipe object it should return true for test to pass
  test "recipe should be valid" do
    assert @recipe.valid?
  end
  
  
  test "chef_id should be present" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
    
  end
  
  #here we want name to be present but we have assigned it an empty string for name so this test should return false for the test to pass
  #asset_not always expects a fales for the test to pass assert expect true for the test to pass
  test "name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
    
  end
  
  
  test "name length should not be too long" do 
    @recipe.name = "a" * 101
    assert_not @recipe.valid?
    
  end
  
  test "name length should not be too short" do 
    @recipe.name = "aaaa"
    assert_not @recipe.valid?
    
  end
  
  test "summary should be present" do
    @recipe.summary = " "
    assert_not @recipe.valid?
    
  end
  
  test "summary length should not be too long" do 
    @recipe.summary = "a" * 151
    assert_not @recipe.valid?
    
   end
  
  test "summary length should not be too short" do 
    @recipe.summary = "a" * 9
    assert_not @recipe.valid?
    
  end
  
  test "description must be present" do 
    @recipe.description = " "
    assert_not @recipe.valid?
    
  end
  
  test "description should not be to long" do
    @recipe.description = " a" * 501
    assert_not @recipe.valid?
    
  end
  
  test "description should not be too short" do  
    @recipe.description = "a" * 19
    assert_not @recipe.valid?
    
  end
  
  
end