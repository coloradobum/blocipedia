class ChargesController < ApplicationController

  before_filter :authenticate_user!

  def create
  # Amount in cents
  @amount = 500

  customer = Stripe::Customer.create(
    :email => 'example@stripe.com',
    :card  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Rails Stripe customer',
    :currency    => 'usd'
  )

  current_user.is_premium_user = true
  current_user.save

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.email}",
      amount: 9_000_000_000_00
    }

  end
end
