require 'rails_helper'

describe User do

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "is valid with a username" do
    expect(build(:user)).to be_valid
  end

  it "is invalid without a username" do
    user = build(:user, username: nil)
    user.valid?
    expect(user.errors[:username]).to include("can't be blank")
  end

  it "is invalid with duplicate username" do
    user1 = create(:user, username: "arish")
    user2 = build(:user, username: "arish")
    user2.valid?
    expect(user2.errors[:username]).to include("has already been taken")
  end

  context "on a new user" do

    it "is invalid without a password" do
      user = build(:user, password: nil, password_confirmation: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "is invalid with less than 8 characters long" do
      user = build(:user, password: "short", password_confirmation: "short")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 8 characters)")
    end

    it "is invalid with a confirmation mismatch" do
      user = build(:user, password: "shortpassword", password_confirmation: "longpassword")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

  end

  context "on an existing user" do
    before :each do
      @user = create(:user)
    end

    it "is invalid with no changes" do
      expect(@user.valid?).to eq(true)
    end

    it "is invalid with an empty password" do
      @user.password_digest = ""
      @user.valid?
      expect(@user.errors[:password]).to include("can't be blank")
    end

    it "is valid with a new (valid) password" do
      @user.password = "newlongpassword"
      @user.password_confirmation = "newlongpassword"
      @user.valid?
      expect(@user.valid?).to eq(true)
    end
  end

  context "add gopay attributes" do
    before :each do
      @user = create(:user)
    end

    it "is valid with default value 200000" do
      expect(@user.gopay).to eq(200000)
    end

    it "is invalid with default value 200000" do
      expect(@user.gopay).to eq(200000)
    end

    it "is invalid if gopay less than 0.01" do
      user1 = build(:user, gopay:0)
      user1.valid?
      expect(user1.errors[:gopay]).to include("must be greater than or equal to 0.01")
    end

    it "is invalid gopay non numeric" do
      user = build(:user, gopay:"dollar")
      user.valid?
      expect(user.errors[:gopay]).to include("is not a number")
    end

    it "is invalid gopay nil" do
      user = build(:user, gopay:nil)
      user.valid?
      expect(user.errors[:gopay]).to include("can't be blank")
    end

    # it "reduce gopay after order save" do
    #   user = create(:user)
    #   order = create(:order, payment_type: "Go Pay", total: 50000, user: user)
    #   User.update_gopay_from_order(order)
    #   expect(user.gopay).to eq(150000)
    # end
  end
end
