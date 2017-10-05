class Item < ApplicationRecord
  belongs_to :decision 
  validates :weight, presence: true
  validates :description, presence: true
  validates :category, presence: true


  validates :category,
  	:inclusion => { :in => ['pro', 'con']}

  	

end
