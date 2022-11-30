# frozen_string_literal: true

RSpec.describe AddToCart do
  let(:user) { create(:user, password: "123456") }
  let(:product_id) { SecureRandom.uuid }
  let(:amount) { 3 }
  let(:params) do
    {
      product_id: product_id,
      amount: amount
    }
  end

  context "when the item is in user's current cart" do
    subject(:adding_to_cart) { described_class.call(user.current_cart, params) }

    it "does not add additional item to the cart" do |example|
      original_amount = 1
      product = create(:product, id: product_id)
      user.current_cart.items.create!(product: product, amount: original_amount)
      expect { adding_to_cart }.not_to change { user.current_cart.items.find_by(product_id: product_id).amount }
    end
  end

  context "when the item is not in user's current cart" do
    subject(:adding_to_cart) { described_class.call(user.current_cart, params) }

    before do
      create(:product, id: product_id)
    end

    it "adds the item to the user's cart" do |example|
      expect { adding_to_cart }.to change { user.current_cart.items.where(product_id: product_id).count }.from(0).to(1)
    end

    it "adds the item with amount 1" do |example|
      expect { adding_to_cart }.to change { user.current_cart.items.find_by(product_id: product_id)&.amount }.from(nil).to(1)
    end
  end
end
