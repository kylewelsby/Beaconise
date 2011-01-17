# encoding: utf-8
# require 'devise/models'
require 'devise_facebook/strategy'

module Devise
	module Models #:nodoc:
		module Facebook
			
			# Facebook Connectable Module, responsible for validating authenticity of a
		  # user and storing credentials while signing in using their Facebook account.
			#
			def self.included(base) #:nodoc:
				base.class_eval do 
					extend ClassMethods
				end
			end
			
			# Store Facebook Connect account/session credentials 
			#
			def store_facebook_credentials!(attributes = {})
				self.send(:"#{self.class.facebook_uid_field}=", attributes[:uid])
				self.send(:"#{self.class.facebook_session_key_field}=", attributes[:session_key])
				
				# Confirm without e-mail - if confirmable module is loaded.
				self.skip_confirmation! if self.respond_to?(:skip_confirmation!)
				
        # Only populate +email+ field if it's available (e.g. if +authenticable+ module is used).
        self.email = attributes[:email] || '' if self.respond_to?(:email)

        # Lazy hack: These database fields are required if +authenticable+/+confirmable+
        # module(s) is used. Could be avoided with :null => true for authenticatable
        # migration, but keeping this to avoid unnecessary problems.
        self.password_salt = '' if self.respond_to?(:password_salt)
        self.encrypted_password = '' if self.respond_to?(:encrypted_password)
			end
			
			# Checks if Facebook Connect:ed.
			#
      def facebook_connected?
        self.send(:"#{self.class.facebook_uid_field}").present?
      end
      alias :is_facebook_connected? :facebook_connected?

			# Hook that gets called *before* connect (each time). Useful for
			# fetching additional user info (etc.) from Facebook.
			#
			# Default: Do nothing.
			#
			def on_before_facebook_connect(data, token=false)
        if self.respond_to?(:before_facebook_connect)
          self.send(:before_facebook_connect, data, token=false) rescue nil
        end
      end

			# Hook that gets called *after* connect (each time). Useful for
			# fetching additional user info (etc.) from Facebook.
			#
			def on_after_facebook_connect(data, token=false)
			  if self.respond_to?(:after_facebook_connect)
			    self.send(:after_facebook_connect, data, token=false) rescue nil
			  end
			end

			module ClassMethods
				
				# Configuration params accessible within +Devise.setup+ procedure (in initalizer).
        #
        # == Example:
        #
        #   Devise.setup do |config|
        #     config.facebook_uid_field = :facebook_uid
        #     config.facebook_session_key_field = :facebook_session_key
        #     config.facebook_auto_create_account = true
        #   end
        #
				::Devise::Models.config(self,
					:facebook_uid_field,
					:facebook_session_key_field,
					:facebook_auto_create_account
				)
				
				# Alias don't work for some reason, so...a more Ruby-ish alias
        # for +facebook_auto_create_account+.
        #
        def facebook_auto_create_account?
          self.facebook_auto_create_account
        end

        # Authenticate a user based on Facebook UID.
        #
        def authenticate_with_facebook(attributes = {})
          if attributes[:uid].present?
            self.find_for_facebook_connect(attributes[:uid])
          end
        end

				protected
				
					# Find first record based on conditions given (Facebook UID).
	        # Overwrite to add customized conditions, create a join, or maybe use a
	        # namedscope to filter records while authenticating.
	        #
	        # == Example:
	        #
	        #   def self.find_for_facebook_connect(uid, conditions = {})
	        #     conditions[:active] = true
	        #     self.find_by_facebook_uid(uid, :conditions => conditions)
	        #   end
	        #
	        def find_for_facebook_connect(uid, conditions = {})
	          self.find_by_facebook_uid(uid, :conditions => conditions)
	        end

	        # Contains the logic used in authentication. Overwritten by other devise modules.
	        # In the Facebook Connect case; nothing fancy required.
	        #
	        def valid_for_facebook_connect(resource, attributes)
	          true
	        end
	
			end
			
		end
	end
end