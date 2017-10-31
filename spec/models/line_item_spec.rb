require 'rails_helper'

describe LineItem do
  it "has a valid factory" do
    expect(build(:line_item)).to be_valid
  end

  it "can calculate total price per line item" do
    food = create(:food, price:15000)
    line_item = create(:line_item, food: food, quantity:2)
    expect(line_item.total_price).to eq(30000)
  end

end

describe Cart do
  it "has a valid factory" do
    expect(build(:cart)).to be_valid
  end

  it "can calculate total cart price" do
    cart = create(:cart)
    food1 = create(:food, price:10000)
    food2 = create(:food, price:15000)
    
    line_item1 = create(:line_item, cart: cart, food: food1, quantity:2)
    line_item2 = create(:line_item, cart: cart, food: food2, quantity:2)
    expect(cart.total_price).to eq(50000)

  end

  it "deletes line_items when deleted" do
    cart = create(:cart)
    food1 = create(:food)
    food2 = create(:food)
    
    line_item1 = create(:line_item, cart: cart, food: food1)
    line_item2 = create(:line_item, cart: cart, food: food2)
    cart.line_items << line_item1
    cart.line_items << line_item2


    expect { cart.destroy }.to change { LineItem.count }.by(-2)
  end
end