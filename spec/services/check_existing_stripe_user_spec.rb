RSpec.describe CheckExistingStripeUser do
  let(:example_stripe_user_id) { "cus_XXXXXXXX" }
  let(:new_user) { create(:user, stripe_customer_id: nil) }
  let(:old_user) { create(:user, stripe_customer_id: example_stripe_user_id) }

  before do
    stripe_customer = double
    allow(stripe_customer).to receive(:id).and_return(example_stripe_user_id)
    allow(Stripe::Customer).to receive(:create).and_return(stripe_customer)
  end

  context "when the user does not exist yet" do
    subject(:create_new_user) { described_class.call(new_user.id) }

    it "sets the stripe user id" do
      expect { create_new_user }.to change { new_user.reload.stripe_customer_id }.from(nil).to(be_a(String))
    end

    it { is_expected.to match_result(nil, :ok) }
  end

  context "when the stripe user already exist" do
    subject(:create_existing_user) { described_class.call(old_user.id) }

    it "does not create the stripe user" do
      expect { create_existing_user }.not_to change { old_user.reload.stripe_customer_id }
    end

    it { is_expected.to match_result(nil, :ok) }
  end
end
