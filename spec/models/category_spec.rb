require 'rails_helper'

describe Category do

  it "is valid with a name and description" do
    expect(build(:category)).to be_valid
  end


  it "is invalid without a name" do
    category = build(:category, name: nil)
    category.valid?
    expect(category.errors[:name]).to include("can't be blank")
  end


  it "is invalid with a duplicate name" do
    cat1 = create(:category, name: "drink")
    cat2 = build(:category, name: "drink")

    cat2.valid?
    expect(cat2.errors[:name]).to include("has already been taken")
  end

  # it "is valid if delete empty category" do
  #   cat1 = create(:category, id: 1, name: "drink")
  #   food1 = create(:food, category_id: 1)

  #   cat2.valid?
  #   expect(cat2.errors[:name]).to include("has already been taken")
  # end

end
