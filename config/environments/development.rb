ENV["RAILS_ASSET_ID"] = ""
# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

config.action_mailer.delivery_method = :smtp
config.action_mailer.default_url_options = { 
  :host => "beaconise.local"
}
config.action_mailer.smtp_settings = {
  :expires              => 60,
  :enable_starttls_auto => true,
  :address              => 'smtp.gmail.com',
  :port                 => 587,
  :domain               => 'beaconise.com',
  :user_name            => "no-reply@beaconise.com",
  :password             => "ov54xou",
  :authentication       => :login
}
config.action_mailer.raise_delivery_errors = false
config.action_mailer.perform_deliveries = true

ENV["GOOGLE_MAPS_KEY"] = "ABQIAAAA6wMmX-OJLVYyafb2fTOexhSeQ5ONvCJZsyeE4-cNt0fpva-YXRQTlxVUns1IjNv1P_q8OyRSOqy0Pg"

ENV['RECAPTCHA_PUBLIC_KEY'] = "6LdAygcAAAAAAANSKypv7L6QjfG-rDk0prGNyK0M" # Valid for snoogleme.com and global
ENV['RECAPTCHA_PRIVATE_KEY'] = "6LdAygcAAAAAANUlW37EJFiuJ7JkPaBtnIsEKQ62" # Valid for snoogleme.com and global