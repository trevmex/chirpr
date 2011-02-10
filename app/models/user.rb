class User < ActiveRecord::Base
  has_many :statuses
  has_one :father
  has_many :jobs
  has_many :companies, :through => :jobs

  validates :name, :presence => true
end
