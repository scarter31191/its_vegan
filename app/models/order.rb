class Order < ActiveRecord::Base
    belongs_to :user

    validates :address, :item, :item_price, :total, :user_id, presence: true
end