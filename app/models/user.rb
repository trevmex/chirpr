class User < ActiveRecord::Base
  attr_accessible :name, :password, :password_confirmation, :description

  attr_accessor :password
  before_save :encrypt_password

  has_many :statuses
  has_one :father
  has_many :jobs
  has_many :companies, :through => :jobs

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :name
  validates_uniqueness_of :name

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate(name, password)
    user = find_by_name(name)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
end
