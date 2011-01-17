# encoding: utf-8
require 'devise/strategies/base'

module Devise #:nodoc:
  module Facebook #:nodoc:
    module Strategies #:nodoc:

      # Default strategy for signing in a user using Facebook Connect (a Facebook account).
      # Redirects to sign_in page if it's not authenticated
      #
      class Facebook < ::Devise::Strategies::Base

        def valid?
          valid_params? and mapping.to.respond_to?('authenticate_with_facebook')
        end
				
				def authenticate!
					klass = mapping.to
					RAILS_DEFAULT_LOGGER.debug("Authenticating with Facebook OAuth for mapping #{klass}")
					# begin
						access_token_hash = MiniFB.oauth_access_token(ENV['FB_APP_ID'], service_url, ENV['FB_SECRET'], params[:code])
						access_token = access_token_hash['access_token']
						response_hash = MiniFB.get(access_token,'me')
						user = klass.authenticate_with_facebook(:uid => response_hash.id)
						if user.present?
							success!(user)
						else
							if klass.facebook_auto_create_account?
								RAILS_DEFAULT_LOGGER.debug("Creating a new account from FaceBook")
								user = returning(klass.new) do |u|
									u.store_facebook_credentials!(
										:session_key => access_token,
										:uid => response_hash.id
									)
									u.on_before_facebook_connect(response_hash, access_token)
								end
								begin
									user.save(false)
									user.on_after_facebook_connect(response_hash, access_token)
									success!(user)
								rescue
									fail!(:facebook_invalid)
									RAILS_DEFAULT_LOGGER.debug("Failed to create account from FaceBook")
								end
							else
								fail!(:facebook_invalid)
							end
						end
					# rescue => e
						# RAILS_DEFAULT_LOGGER.debug e.message
						# fail!(e.message)
					# end
					
				end
				
				protected
					def valid_params?
						params[:code].present?				
					end
					def service_url
		        url = URI.parse(request.url)
		        url.path = "#{mapping.parsed_path}/#{mapping.path_names[:sign_in]}"
		        url.query = nil
		        url.to_s
		      end
      end
    end
  end
end

Warden::Strategies.add(:facebook, Devise::Facebook::Strategies::Facebook)
