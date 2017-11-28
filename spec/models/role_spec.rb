require 'rails_helper'

describe Role do
  it "has a valid factory" do
    expect(build(:role)).to be_valid
  end

  it "is valid with a name" do
    expect(build(:role)).to be_valid
  end

   it "is invalid without a name" do
    role = build(:role, name:nil)
    role.valid?
    expect(role.errors[:name]).to include("can't be blank")
  end

  it "is invalid with duplicate name" do
    role1 = create(:role, name:"administrator")
    role2 = build(:role, name:"administrator")
    role2.valid?
    expect(role2.errors[:name]).to include("has already been taken")
  end

end
