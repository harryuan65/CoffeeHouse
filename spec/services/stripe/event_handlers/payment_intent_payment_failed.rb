RSpec.describe Stripe::EventHandlers::PaymentIntentPaymentFailed, payment: :stripe do
  subject(:handle_payment_intent_failed) { described_class.call(payment_intent) }

  let(:payment_intent) do
    stripe_object_from("failed_card/payment_intent.payment_failed.json")
  end

  let!(:user) { create(:user, stripe_customer_id: payment_intent[:customer]) }

  it "creates a stripe payment" do
    expect { handle_payment_intent_failed }.to change(StripePayment, :count).by(1)
  end

  it "creates a failed order" do
    expect { handle_payment_intent_failed }.to change { user.orders.failed.count }.by(1)
  end

  it { is_expected.to match_result(nil, :bad_request, /Your card's security code is incorrect./) }
end
