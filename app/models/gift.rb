class Gift < ApplicationRecord
  #----------------------------------#
  # Gifts Model Definition
  # original written by: Andy W, Oct 13 2016
  # major contributions by:
  #             Wei H, Oct 15 2016
  #             Pat M, Oct 17 2016
  #----------------------------------#
  
  belongs_to :donor
  belongs_to :activity
  default_scope -> {order(created_at: :desc)}
  validates :donation_date, presence: true
  validates :amount, presence: true, :numericality => {:greater_than_or_equal_to => 0}
  
  # Export Gifts
  # outputs all gifts as a csv file(all attributes included).
  def self.import(file, activity)
    
    CSV.foreach(file.path, headers: true) do |row|
      gift_hash = row.to_hash 
      # imported gifts are assigned an activity at import time
      gift_hash["activity_id"] = activity
      
      gift = Gift.where(id: gift_hash["id"])

      if gift.count == 1
        gift.first.update_attributes(gift_hash)
      else
        Gift.create!(gift_hash)
      end # end if else
    end # end foreach
  end
end
