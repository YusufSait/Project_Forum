class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  has_many :comments
  has_many :topics
end
