# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_beaconise_session',
  :secret      => 'b9fd9ec7ce7264f01c1497ff272e80e94b1d622f2c91bd386b0ed671e66ea2095d53d925284c7abaffa332e948c337ed164be1f7edd6eaf650651a4017112330'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store

# ActionController::Dispatcher.middleware.insert_before(
#   ActionController::Session::CookieStore, 
#   FlashSessionCookieMiddleware,       
#   ActionController::Base.session_options[:key]
# )

# ActionController::Dispatcher.middleware.insert_before(
#   ActionController::Base.session_store, 
#   FlashSessionCookieMiddleware, 
#   ActionController::Base.session_options[:key]
# )