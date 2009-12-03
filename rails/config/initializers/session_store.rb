# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_cpves_session',
  :secret      => '523976c159521252b45bebee77857dd815a0b9fd6dfc3a8a98e837bfde3b255fd1c288f39c0ec15275fb9a6c7a79dba8b8b289cb5d40c78163d706a5ea54d8e1'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
