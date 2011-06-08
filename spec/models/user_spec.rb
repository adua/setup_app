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
    @attr = { :name => "Example User", :email => "user@example.com" }
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
end
