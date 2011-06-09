require 'spec_helper'

describe User do

#  it "should accept a valid e-mail address" do
#    addresses = %w[user@foo.com user.test@foo.com user@foo.net user@foo.jp user@foo.bar.us]
#    addresses.each do |address|
#      valid_email_user = User.new(@attr.merge(:email => address))
#      valid_email_user.should_be_valid
#    end
#end

  before(:each) do
    @attr = { :name => "Example User",
              :email => "user@example.com",
              :password => "foobar",
              :password_confirmation => "foobar"
            }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should not accept invalid e-mail addresses" do
    addresses = %w[user@foo,com useratfoo.com]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject a duplicate user email" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject duplicate upcase email" do
    User.create!(@attr)
    upcased_email = @attr[:email].upcase
    user_with_upcase_email = User.new(@attr.merge(:email => upcased_email))
    user_with_upcase_email.should_not be_valid
  end

describe "password validations" do

  it  "should not be empty" do
    User.new(@attr.merge(:password => "", :password_confirmations => ""))
      should_not be_valid
  end

  it  "should have a matching password confirmation" do
    test_pw = "ABC"*3
    User.new(@attr.merge(:password_confirmation => test_pw))
    should_not be_valid
  end

  it "should be longer than 5 characters" do
    short_pw = "1"*5
    hash = @attr.merge(:password => short_pw, :password_confirmations => short_pw)
    User.new(hash).should_not be_valid
  end

  it "should be shorter than 21 characters" do
    long_pw = "A"*21
    hash = @attr.merge(:password => long_pw, :password_confirmations => long_pw)
    User.new(hash).should_not be_valid
  end

  before(:each) do
    @user = User.create!(@attr)
  end

  it "should have an encrypted password attribute" do
    @user.should respond_to(:encrypted_password)
  end

  describe "authenticate method" do

    it "should return nil on email password mismatch" do
      wrong_password_user = User.authenticate(@attr[:email], "incorrect")
      wrong_password_user.should be_nil
    end

    it "should return nil for an e-mail address w/ no user" do
      does_not_exist_user = User.authenticate("foo@bar.com", "blahbiddyblah")
      does_not_exist_user.should be_nil
    end

    it "should return the user on successful login" do
      successful_user = User.authenticate(@attr[:email], @attr[:password])
      successful_user.should == @user
    end
   end
  end
end


