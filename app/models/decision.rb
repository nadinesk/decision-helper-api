class Decision < ApplicationRecord
  belongs_to :user
  
  has_many :items, dependent: :destroy

  validates :title, presence: true

  def total
  	t = 0
   	self.items.each do |item|
   		if item.category == 'pro'
   			t += item.weight
   		elsif item.category == 'con'
   			t -= item.weight
   		else
   			t += 0
   		end
   	end
   	return t;
  end
end
