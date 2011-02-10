class Status < ActiveRecord::Base
  belongs_to :user

  validates :description,
    :presence => true,
    :length => {:maximum => 140}
end
