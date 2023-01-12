RSpec.describe Stripe::OrderToLineItems do
  let(:order) { create(:order, :with_some_items) }
  let(:order_items) { order.items.includes(:product) }

  it "maps order items to line items" do
    line_items = order_items.map { |item| Stripe::LineItemVO.new(price: item.product.stripe_price_id, quantity: item.amount) }
    output = described_class.call(order).output
    expect(output).to eq(line_items)
  end
end
