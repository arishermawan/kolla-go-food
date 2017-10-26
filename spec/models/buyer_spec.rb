require 'rails_helper'

describe Buyer do

  it "is valid with a email, name, phone, and address" do
    expect(build(:buyer)).to be_valid
  end

end