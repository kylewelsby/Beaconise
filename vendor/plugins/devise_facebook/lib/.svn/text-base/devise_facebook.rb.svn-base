# DeviseFacebook
# encoding: utf-8
require 'devise'
require 'hashie'
require 'mini_fb'

require 'devise_facebook/model'
require 'devise_facebook/strategy'
require	'devise_facebook/schema'
require 'devise_facebook/routes'
# require 'devise_facebook/controller_filters'
require 'devise_facebook/view_helpers'

module Devise
  # Specifies the name of the database column name used for storing
  # the user Facebook UID. Useful if this info should be saved in a
  # generic column if different authentication solutions are used.
  mattr_accessor :facebook_uid_field
  @@facebook_uid_field = :facebook_uid

  # Specifies the name of the database column name used for storing
  # the user Facebook session key. Useful if this info should be saved in a
  # generic column if different authentication solutions are used.
  mattr_accessor :facebook_session_key_field
  @@facebook_session_key_field = :facebook_session_key

  # Specifies if account should be created if no account exists for
  # a specified Facebook UID or not.
  mattr_accessor :facebook_auto_create_account
  @@facebook_auto_create_account = true
	
end

# Load core I18n locales: en
#
I18n.load_path.unshift File.join(File.dirname(__FILE__), *%w[devise_facebook locales en.yml])

Devise.add_module(:facebook,
  :strategy => true,
  :controller => :facebook_auth,
	:route => :facebook,
  :model => 'devise_facebook/model')