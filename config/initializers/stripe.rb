if Rails.env.production?
  Rails.configuration.stripe = {
    :publishable_key => ENV['STRIPE_PUBLISHABLE_KEY'],
    :secret_key => ENV['STRIPE_SECRET_KEY']
  }
else
  Rails.configuration.stripe = {
    :publishable_key => 'pk_test_5pCpHwVCblyMxVRUa5Mvp3iv',
    :secret_key => 'sk_test_S8pKLU3USHNUPvOMrQ4OqeDv'
  }
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]