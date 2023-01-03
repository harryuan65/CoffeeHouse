RSpec.describe Stripe::EventHandlers::CheckoutSessionCompleted, payment: :stripe do
  subject(:handle_checkout_session_completed) { described_class.call(checkout_session) }

  let(:checkout_session) do
    stripe_object_from("successful_card/checkout.session.completed.json")
  end
  let(:user) { create(:user, stripe_customer_id: checkout_session[:customer]) }

  # Mock stripe line items by creating cart and its products first, and use them to create a stubbed stripe list object.
  let(:cart) { create(:cart, :with_some_items, user: user) }
  let(:list_object) { cart_to_stripe_list_object(cart) }

  before do
    allow(Stripe::Checkout::Session).to receive(:list_line_items).with(checkout_session[:id]).and_return(list_object)
  end

  it "creates a stripe payment" do
    expect { handle_checkout_session_completed }.to change(StripePayment, :count).by(1)
  end

  it "creates a order" do
    expect { handle_checkout_session_completed }.to change { user.orders.completed.count }.by(1)
  end

  context "when checking the new order" do
    before { handle_checkout_session_completed }

    it "has the correct amount for the purchased product" do
      order = user.orders.includes(items: :product).completed.last
      order_items_count = order.items.count
      cart_count = Cart.where(user_id: user.id).includes(items: :product).last.items.count
      expect(order_items_count).to eq(cart_count)
    end

    # :reek:UtilityFunction
    # order_items or cart_items
    def summary_of(items)
      items.each_with_object({}) do |item, res|
        amount = item.amount
        res[item.product_id] = {
          amount: amount,
          product_price: item.product.price * amount
        }
      end
    end

    it "has the correct amount for each purchased product" do
      order_items = user.orders.includes(items: :product).completed.last.items
      cart_items = Cart.includes(items: :product).where(user_id: user.id).last.items
      order_summary = summary_of(order_items)
      cart_summary = summary_of(cart_items)
      expect(order_summary).to eq(cart_summary)
    end
  end
end
