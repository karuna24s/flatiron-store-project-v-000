class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items, dependent: :destroy
  has_many :items, through: :line_items

  def total
    total =  0
    self.line_items.collect do |line_item|
      total+= line_item.item.price * line_item.quantity
    end
    total
  end

  def add_item(item_id)
    line_item = self.line_items.find_by(item_id:item_id)
    if line_item.blank?
      item = Item.find_by(id: item_id)
      item.line_items.build(quantity: 1, cart: self)
    else line_item
      line_item.quantity += 1
      line_item
    end
  end

end
