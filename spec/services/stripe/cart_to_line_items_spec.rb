RSpec.describe Stripe::CartToLineItems do
  let(:cart) { create(:cart, :with_some_items) }
  let(:cart_items) { cart.items.includes(:product) }

  it "maps cart items to line items" do
    line_items = cart_items.map { |item| Stripe::LineItemVO.new(price: item.product.stripe_price_id, quantity: item.amount) }
    output = described_class.call(cart).output
    expect(output).to eq(line_items)
  end
end
