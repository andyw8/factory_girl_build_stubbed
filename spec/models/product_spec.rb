require 'spec_helper'

shared_examples "a product with settable attributes" do
  it "a product with settable attributes" do
    product.name = "foo"
    expect(product.name).to eq "foo"
  end
end

describe "Product factory strategies" do
  context "#build" do
    it_behaves_like "a product with settable attributes"

    let(:product) { FactoryGirl.build(:product) }

    it "returns an new Product instance" do
      expect(product).to be_a_new Product
    end

    it "does not persist" do
      expect(product).to_not be_persisted
    end

    it "can be saved" do
      expect { product.save! }.not_to raise_error
    end
  end

  context "#create" do
    it_behaves_like "a product with settable attributes"

    let(:product) { FactoryGirl.create(:product) }

    it "returns a Product instance" do
      expect(product).to be_a Product
    end

    it "persists to the database" do
      expect { product.save! }.to change { Product.count }.by(1)
    end
  end

  context "#attributes_for" do
    # note: does not behave like "a product with settable attributes"

    let(:product) { FactoryGirl.attributes_for(:product) }

    it "returns a hash" do
      expect(product).to be_a Hash
    end
  end

  context "#build_stubbed" do
    it_behaves_like "a product with settable attributes"

    let(:product) { FactoryGirl.build_stubbed(:product) }

    it "returns a Product instance" do
      expect(product).to be_a Product
    end

    it "stubs out activerecord methods" do
      expect { product.save! }.not_to raise_error
    end

    it "does not persist to the database" do
      expect { product.save! }.to_not change { Product.count }
    end
  end
end
