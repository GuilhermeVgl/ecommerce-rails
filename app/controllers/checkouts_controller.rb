class CheckoutsController < ApplicationController
  def create
    stripe_secret_key = Rails.application.credentials.dig(:stripe, :secret_key)
    Stripe.api_key = stripe_secret_key
    cart = params[:cart]
    line_items = cart.map do |item|
      product = Product.find(item["id"])

      {
        quantity: item["quantity"].to_i,
        price_data: {
          product_data: {
            name: item["name"],
            metadata: { product_id: product.id }
          },
          currency: "BRL",
          unit_amount: item["price"].to_i
        }
      }
    end

    puts "line_items: #{line_items}"

    session = Stripe::Checkout::Session.create(
      mode: "payment",
      line_items: line_items,
      success_url: "http://localhost:3000/success",
      cancel_url: "http://localhost:3000/cancel",
      shipping_address_collection: {
        allowed_countries: ['BR']
      }
    )

    render json: { url: session.url }
  end

  def success
    render :success
  end

  def cancel
    render :cancel
  end
end
