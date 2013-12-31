class User < ActiveRecord::Base
  include Sluggable

  has_many		:posts
  has_many		:comments
  has_many		:votes

  has_secure_password validations: false
  
  validates 	:username, presence: true, uniqueness: true
  validates		:password, presence: true, on: :create, length: {minimum: 5}

  sluggable_column :username

  def admin?
    self.role == 'admin'
  end

  def moderator?
    self.role == 'moderator?'
  end

  def two_factor_auth?
    !self.phone.blank?
  end

  def remove_pin!
    self.update_column(:pin, nil)
  end

  def generate_pin!
    self.update_column(:pin, rand(10 ** 6)) # random 6 digit number
  end

  def sent_pin_to_twilio
    # Get your Account Sid and Auth Token from twilio.com/user/account
    account_sid = 'ACa71b5aa437499394b71deebb41f10a97'
    auth_token = '1a6f4d3b2c2a69a78c4467982e5eda6f'
    
    client = Twilio::REST::Client.new account_sid, auth_token
    
    msg = "Hi, please input the pin to continue login: #{self.pin}"
    phone = "+86#{self.phone}"
    client.account.messages.create({
      :from => '+16209109504', 
      :to => phone, 
      :body => msg,  
      })
  end
end