require 'rails_helper'

describe Voucher do

  it "has a valid factory" do
  end

  it "is valid with a code, valid_from, valid_through, amount, unit_type, max_amount" do
  end

  it "is invalid without a code" do
    voucher = build(:voucher, code: nil)
    voucher.valid?
    expect(voucher.errors[:code]).to include("can't be blank")
  end

  it "is invalid without a valid_from" do
    voucher = build(:voucher, valid_from: nil)
    voucher.valid?
    expect(voucher.errors[:valid_from]).to include("can't be blank")
  end

  it "is invalid without a valid_through" do
    voucher = build(:voucher, valid_through: nil)
    voucher.valid?
    expect(voucher.errors[:valid_through]).to include("can't be blank")
  end

  it "is invalid without an unit_type" do
    voucher = build(:voucher, unit_type: nil)
    voucher.valid?
    expect(voucher.errors[:unit_type]).to include("can't be blank")
  end

  it "is invalid with a duplicate code" do
    voucher1 = create(:voucher, code: "GOJEKINAJA")
    voucher2 = build(:voucher, code: "GOJEKINAJA")
    voucher2.valid?
    expect(voucher2.errors[:code]).to include("has already been taken")
  end

  it "is invalid if amount less than 0.01" do
    voucher = build(:voucher, amount:0)
    voucher.valid?
    expect(voucher.errors[:amount]).to include("must be greater than or equal to 0.01")
  end

  it "is invalid if max_amount less than 0.01" do
    voucher = build(:voucher, max_amount:0)
    voucher.valid?
    expect(voucher.errors[:max_amount]).to include("must be greater than or equal to 0.01")
  end

  describe "amount must be numeric" do
    before :each do
      @voucher1 = build(:voucher, amount: 15)
      @voucher2 = build(:voucher, amount: "123a")
    end

    context "with numeric input amount" do
      it "is valid amount numeric" do
        expect(@voucher1.valid?).to eq(true)
      end
    end

    context "with non numeric input amount" do
      it "is invalid amount numeric" do
        @voucher2.valid?
        expect(@voucher2.errors[:amount]).to include("is not a number")
      end
    end
  end

  describe "max_amount must be numeric" do
    before :each do
      @voucher1 = build(:voucher, max_amount: 15)
      @voucher2 = build(:voucher, max_amount: "123a")
    end

    context "with numeric input max_amount" do
      it "is valid max_amount numeric" do
        expect(@voucher1.valid?).to eq(true)
      end
    end

    context "with non numeric input max_amount" do
      it "is invalid max_amount numeric" do
        @voucher2.valid?
        expect(@voucher2.errors[:max_amount]).to include("is not a number")
      end
    end
  end
end
