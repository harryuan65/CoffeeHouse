RSpec.describe MapCartToOrderItems do
  subject(:order_items) { described_class.call(cart).output }

  let(:user) { create(:user) }
  let(:cart) { create(:cart, :with_some_items, user_id: user.id) }
  let(:cart_items) { cart.items.includes(:product) }

  it "initializes order items from cart items" do
    cart_items.each_with_index do |cart_item, index|
      order_item = order_items[index]
      expect([order_item.product_id, order_item.amount, order_item.total_price]).to eq([cart_item.product_id, cart_item.amount, cart_item.amount * cart_item.product.price])
    end
  end
end
