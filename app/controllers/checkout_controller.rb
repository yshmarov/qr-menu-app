class CheckoutController < ApplicationController
  session = Stripe::Checkout::Session.create({
    mode: "payment",
    success_url: "https://example.com/success",
    cancel_url: "https://example.com/cancel"
  })

  redirect_to session.url, allow_other_host: true
end
