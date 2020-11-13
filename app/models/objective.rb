class Objective < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :idea, presence: true
  validates :content, presence: true
 
end