require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(chefname: "christ", email: "christ@makedish.com")
  
  end
  
  test " chef should  be valid" do
     assert @chef.valid?
    
  end
  
  test "chefname should be present" do 
    @chef.chefname = " "
    assert_not @chef.valid?
  end
  
  test "chefname should not be too short" do 
    @chef.chefname = "bb" 
    assert_not @chef.valid?
  end
  
  test "chefname should not be too long" do
    @chef.chefname = "b" * 41
    assert_not @chef.valid?
    
  end
  
  test "email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
    
  end
  
  test "email length should not be within bounds" do
    @chef.email = "a" * 101 + "@makedish.com"
    assert_not @chef.valid?
    
  end
  
  #this test is cheching for duplicate email it is testing for email uniqueness every 
  #email should just be one if it if same email is used it should not be stored in the database 
  #this test should one email is save twice user can not use same email to create two different 
  #accounts here we are duplication the chef object we have. it also check that email is not case sensitive
  test "email address should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
    
  end
  
  #this is checking that emial addreeses format are valid if format is valid it should accet
  test "email validation should accept valid addresses" do 
    valid_addresses = %w[user.@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@eem.au laura+joe@monk.cm]
    valid_addresses.each do |val|
      @chef.email = val
      assert @chef.valid?, '#{val.inspect} should be valid'
    
    end
    
  end
  
  #should reject invalid email addresses format if fromat is not valid it should be rejected
  
  test "email validation should reject invalid addresses" do 
    invalid_addresses = %w[user@example,com user_at_eee.org user.name@example. eee@i_am_.com foo@eee+aar.com]
    invalid_addresses.each do |inval|
      @chef.email = inval
      assert_not @chef.valid?,  '#{inval.inspect} should be invalid'
      
    end
  end
  
end