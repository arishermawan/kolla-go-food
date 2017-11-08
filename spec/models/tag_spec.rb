require 'rails_helper'

describe Tag do

  it "has valid factory" do
    expect(build(:tag)).to be_valid
  end

  it "has valid with a name" do
    expect(build(:tag)).to be_valid
  end

  it "is invalid without a name" do
    tag = build(:tag, name: nil)
    tag.valid?
    expect(tag.errors[:name]).to include("can't be blank")
  end

  it "is invalid with duplicate name" do
    tag1 = create(:tag, name: "streetfood")
    tag2 = build(:tag, name: "streetfood")
    tag2.valid?
    expect(tag2.errors[:name]).to include("has already been taken")
  end
end
