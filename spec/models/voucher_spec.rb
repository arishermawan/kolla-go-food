require 'rails_helper'

describe Voucher do

  it "has a valid factory" do
    expect(build(:voucher)).to be_valid
  end

  it "is valid with a code, valid_from, valid_through, amount, unit_type, max_amount" do
    expect(build(:voucher)).to be_valid
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

  it "invalid with wrong unit_type" do
    expect{ build(:voucher, unit_type: "dollar")}. to raise_error(ArgumentError)
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

  it 'is code saved with upcase format' do
    voucher = create(:voucher, code: 'downcase')
    expect(voucher.code).to eq('DOWNCASE')
  end

  it 'with a invalid format date valid_from' do
    voucher = build(:voucher, valid_from: 'badformat')
    voucher.valid?
    expect(voucher.errors[:valid_from]).to include("is invalid Date")
  end

  it 'with a invalid format date valid_through' do
    voucher = build(:voucher, valid_through: 'badformat')
    voucher.valid?
    expect(voucher.errors[:valid_through]).to include("is invalid Date")
  end

  it 'invalid if valid_through < valid_from' do
    voucher = build(:voucher, valid_through: '2017-11-6', valid_from: '2017-11-7')
    voucher.valid?
    expect(voucher.errors[:valid_through]).to include("must be greater than or equal to valid_from")
  end

  context "with unit value is rupiah" do
    it "invalid with max_amount less than amount" do
      voucher = build(:voucher, unit_type:0, amount:9000, max_amount: 8000)
      voucher.valid?
      expect(voucher.errors[:max_amount]).to include("must be greater or equal to amount")
    end
  end

  it "is invalid with case insensetive duplicate cod" do
    voucher1 = create(:voucher, code: "gojekinaja")
    voucher2 = build(:voucher, code: "GOJEKINAJA")
    voucher2.valid?
    expect(voucher2.errors[:code]).to include("has already been taken")
  end

  it "cant be destroy while it hash order" do
    voucher = create(:voucher)
    order = create(:order, voucher: voucher)
    voucher.orders << order
    expect{voucher.destroy}.not_to change(Voucher, :count)
  end
end
