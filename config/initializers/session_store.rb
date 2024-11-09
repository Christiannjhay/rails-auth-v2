# config/initializers/session_store.rb
Rails.application.config.session_store :cookie_store, 
  key: '_hotel_app_session', 
  expire_after: 1.minutes
