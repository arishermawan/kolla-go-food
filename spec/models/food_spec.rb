require 'rails_helper'

describe Food do


  it "can't be destroyed while it has line_item(s)" do
    cart = create(:cart)
    food = create(:food)
    
    line_item = create(:line_item, cart: cart, food: food)
    food.line_items << line_item

    expect { food.destroy }.not_to change(Food, :count)
  end

  it "is valid with a name and description" do
    # food = Food.new(
    #   name: "Nasi Uduk",
    #   description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
    #   price: 10000.0
    # )
    expect(build(:food)).to be_valid
  end

  # describe "is invalid without a name or description" do
  #   before :each do
  #     @food = Food.new(
  #       name: nil,
  #       description: nil,
  #       price: 10000.0
  #     )
  #   end

  #   context "without name" do
  #     it "is invalid without name" do
  #       @food.valid?
  #       expect(@food.errors[:name]).to include("can't be blank")
  #     end
  #   end

  #   context "without description" do
  #     it "is invalid without description" do
  #       @food.valid?
  #       expect(@food.errors[:description]).to include("can't be blank")
  #     end
  #   end
  # end

  it "is invalid without a name" do
    # food = Food.new(
    #   name: nil,
    #   description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
    #   price: 10000.0
    # )
    food = build(:food, name: nil)
    food.valid?
    expect(food.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a description" do
    # food = Food.new(
    #   name: "Nasi Uduk",
    #   description: nil,
    #   price: 10000.0
    # )
    food = build(:food, description: nil)
    food.valid?
    expect(food.errors[:description]).to include("can't be blank")
  end

  it "is invalid with a duplicate name" do
    food1 = Food.create(
      name: "Nasi Uduk",
      description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
      price: 10000.0
    )

    food2 = Food.new(
      name: "Nasi Uduk",
      description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
      price: 10000.0
    )

    food2.valid?
    expect(food2.errors[:name]).to include("has already been taken")
  end

  it "returns a sorted array of results that match" do
    food1 = Food.create(
      name: "Nasi Uduk",
      description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
      price: 10000.0
    )

    food2 = Food.create(
      name: "Kerak Telor",
      description: "Betawi style traditonal spicy ommelete wit glutinous rice cooker",
      price: 8000.0
    )

    food3 = Food.create(
      name: "Nasi Semur Jengkol",
      description: "Based on dongfruit, this menu promises a delicious taste",
      price: 8000.0
    )
    expect(Food.by_letter("N")).to eq([food3, food1])
  end

  it "omits results that do not match" do
    food1 = Food.create(
      name: "Nasi Uduk",
      description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
      price: 10000.0
    )

    food2 = Food.create(
      name: "Kerak Telor",
      description: "Betawi style traditonal spicy ommelete wit glutinous rice cooker",
      price: 8000.0
    )

    food3 = Food.create(
      name: "Nasi Semur Jengkol",
      description: "Based on dongfruit, this menu promises a delicious taste",
      price: 8000.0
    )
    expect(Food.by_letter("N")).not_to eq(food2)
  end

  describe "filter name by letter" do
    before :each do
      @food1 = Food.create(
        name: "Nasi Uduk",
        description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
        price: 10000.0
      )

      @food2 = Food.create(
        name: "Kerak Telor",
        description: "Betawi style traditonal spicy ommelete wit glutinous rice cooker",
        price: 8000.0
      )

      @food3 = Food.create(
        name: "Nasi Semur Jengkol",
        description: "Based on dongfruit, this menu promises a delicious taste",
        price: 8000.0
      )
    end

    context "it macthing letters" do
      it "returns a sorted array of results that match" do
        expect(Food.by_letter("N")).to eq([@food3, @food1])
      end
    end

    context "with non matching letters do" do
      it "omits results that do not match" do
         expect(Food.by_letter("N")).not_to eq(@food2)
      end
    end
  end

  describe "price must be numeric" do
    before :each do
      @food1 = Food.new(
        name: "Nasi Uduk",
        description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
        price: 10000.0
      )

      @food2 = Food.new(
        name: "Kerak Telor",
        description: "Betawi style traditonal spicy ommelete wit glutinous rice cooker",
        price: "1000abc"
      )
    end

    context "with numeric input price" do
      it "is valid price numeric" do
        expect(@food1.valid?).to eq(true)
      end
    end

    context "with non numeric input price" do
      it "is invalid price numeric" do
        @food2.valid?
        expect(@food2.errors[:price]).to include("is not a number")
      end
    end
  end

  it "is invalid if price less than 0.01" do
    food = Food.new(
      name: "Nasi Uduk",
      description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
      price: 0
    )
    food.valid?
    expect(food.errors[:price]).to include("must be greater than or equal to 0.01")
  end

  it "is invalid if image url string end with anything other than \".gif\", \".jpg\" or\".png\", " do
    food = Food.new(
      name: "Nasi Uduk",
      description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
      price: 10000.0,
      image_url:"tenderloin"
    )
    food.valid?
    expect(food.errors[:image_url]).to include("must be a URL for GIF, JPG, or PNG Image.")
  end

  it "is invalid with a duplicate name" do
    food1 = create(:food, name: "Nasi Kuning")
    food2 = build(:food, name: "Nasi Kuning")
    food2.valid?
    expect(food2.errors[:name]).to include("has already been taken")
  end


  it "is invalid if price less than 0.01" do
    food = build(:food, price:0)
    food.valid?
    expect(food.errors[:price]).to include("must be greater than or equal to 0.01")
  end


  it "is invalid if image url string end with anything other than \".gif\", \".jpg\" or\".png\", " do
    food = build(:food, image_url:"tenderloin")
    food.valid?
    expect(food.errors[:image_url]).to include("must be a URL for GIF, JPG, or PNG Image.")
  end


  describe "price must be numeric" do
    before :each do
      @food1 = build(:food)
      @food2 = build(:food, price: "123a")
    end

    context "with numeric input price" do
      it "is valid price numeric" do
        expect(@food1.valid?).to eq(true)
      end
    end

    context "with non numeric input price" do
      it "is invalid price numeric" do
        @food2.valid?
        expect(@food2.errors[:price]).to include("is not a number")
      end
    end
  end


describe "filter name by letter" do
  before :each do
    @food1 = create(:food, name:"Nasi Rames")
    @food2 = create(:food, name:"Semangka")
    @food3 = create(:food, name:"Nasi Kuning")
  end

  context "it macthing letters" do
    it "returns a sorted array of results that match" do
      expect(Food.by_letter("N")).to eq([@food3, @food1])
    end
  end

  context "with non matching letters do" do
    it "omits results that do not match" do
       expect(Food.by_letter("N")).not_to eq(@food2)
    end
  end
end

  describe Food do
    it "has a valid factory" do
      expect(build(:food)).to be_valid
    end
  end

end