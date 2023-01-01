RSpec.describe Stripe::CreateOneTimeCheckout do
  let(:user) { create(:user, stripe_customer_id: "cus_#{SecureRandom.base58(24)}") }
  let(:line_items) { 5.times.map { Stripe::LineItemVO.new(price: "price_#{SecureRandom.base58(24)}", quantity: 1) } }
  let(:service_options) do
    {
      user: user,
      line_items: line_items,
      success_url: "https://success_url",
      cancel_url: "https://cancel_url"
    }
  end
  let(:stripe_args) do
    {
      line_items: line_items.map(&:to_h),
      success_url: "https://success_url",
      cancel_url: "https://cancel_url",
      payment_method_types: ["card"],
      mode: "payment",
      customer: user.stripe_customer_id,
      client_reference_id: user.id
    }
  end

  it "creates one time checkout with correct arguments" do
    stripe_spy = class_double(Stripe::Checkout::Session)
    allow(stripe_spy).to receive(:create).with(any_args)
    stub_const("Stripe::Checkout::Session", stripe_spy)

    described_class.call(service_options)
    expect(stripe_spy).to have_received(:create).with(stripe_args)
  end
end
