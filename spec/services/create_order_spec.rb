RSpec.describe CreateOrder do
  let(:user) { create(:user) }
  let(:product_mappings) do
    3.times.map do |i|
      ActionController::Parameters.new({"id" => create(:product).id, "amount" => i + 1})
    end
  end
  let(:order_params) do
    {
      shipping_method_id: create(:shipping_method).id,
      products: product_mappings,
      shipment_city: Faker::Address.city
    }
  end

  context "when given correct params" do
    subject(:create_order) { described_class.call(user, order_params) }

    it "creates an order" do
      expect { create_order }.to change(Order, :count).by(1)
    end

    it "creates a shipment for the order" do
      expect { create_order }.to change(Shipment, :count).by(1)
    end

    context "when inspecting the order" do
      it "has correct order items" do
        order = create_order.output
        # puts order.association_cached?(:items) # true
        # ActiveRecord::Associations::Preloader.new(records: [order], associations: [:items]).call
        order_summary = order.items.map do |item|
          {"id" => item.product.id, "amount" => item.amount}
        end
        expect(order_summary).to eq(product_mappings)
      end
    end
  end

  context "when given bad params" do
    subject(:bad_create_order) do
      bad_params = order_params.dup
      bad_params.delete(:shipment_city)
      described_class.call(user, bad_params)
    end

    it "does not create any order" do
      expect { bad_create_order }.to raise_error(Validator::ValidationError).and change(Order, :count).by(0)
    end

    it "does not create any shipment" do
      expect { bad_create_order }.to raise_error(Validator::ValidationError).and change(Shipment, :count).by(0)
    end

    it "does not create any order_item" do
      expect { bad_create_order }.to raise_error(Validator::ValidationError).and change(OrderItem, :count).by(0)
    end
  end
end
