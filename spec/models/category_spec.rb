require 'rails_helper'

describe Category do

  it "is valid with a name" do
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

    it "is invalid with a duplicate name" do
    cat1 = create(:category, name: "drink")
    cat2 = build(:category, name: "drink")

    cat2.valid?
    expect(cat2.errors[:name]).to include("has already been taken")
  end


  describe "check category is empty food" do
    before :each do
      @cat1 = create(:category, name:"Traditional", id: 1)
      @cat2 = create(:category, name:"Fast Food", id: 2)

      @food1 = create(:food, name:"Nasi Rames", category_id: 1)
      @food2 = create(:food, name:"Semangka", category_id: 1)

    end

    context "it dont have association with food" do
      it "return a true " do
         expect(Category.category_empty?(@cat2)).to eq(true)
      end
    end

    context "it have association with food" do
      it "returns a false" do
        expect(Category.category_empty?(@cat1)).to eq(false)
      end
    end
  end

  it "cant be destroyed while it has food(s)" do
    category = create(:category)
    food = create(:food, category: category)
    category.foods << food
    
    expect {category.destroy}.not_to change(Category, :count)
  end


  describe "filter Food by category_id" do
    before :each do
      @cat1 = create(:category, name:"Traditional", id: 1)
      @cat2 = create(:category, name:"Fast Food", id: 2)

      @food1 = create(:food, name:"Nasi Rames", category_id: 1)
      @food2 = create(:food, name:"Semangka", category_id: 1)
      @food3 = create(:food, name:"Semangkas", category_id: 2)
    end

    context "it macthing category_id" do
      it "returns a sorted array of results that match" do
        expect(Category.by_category(1)).to eq([@food1, @food2])
      end
    end

    context "with non matching letters do" do
      it "omits results that do not match" do
         expect(Category.by_category(1)).not_to eq(@food3)
      end
    end
  end
end
  