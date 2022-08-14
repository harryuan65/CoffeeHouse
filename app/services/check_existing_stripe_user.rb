# frozen_string_literal: true

#
# Create a Stripe User for the user if not exist
#
class CheckExistingStripeUser < ApplicationService
  def initialize(user_id)
    @user = User.find(user_id)
  end

  # :reek:DuplicateMethodCall { allow_calls: ['complete'] }
  def call
    return complete(nil, :ok) if @user.stripe_customer_id

    customer = Stripe::Customer.create({
      email: @user.email,
      metadata: {user_id: @user.id}
    })
    @user.stripe_customer_id = customer.id

    if @user.save
      complete(nil, :ok)
    else
      complete(nil, :bad_request, @user.errors.full_messages.join("\n"))
    end
  end
end
