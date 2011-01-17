# encoding: utf-8
require 'devise/mapping'

module Devise #:nodoc:
	module Facebook #:nodoc:
		module Helpers
			def facebook_sign_in_link(*args)
				scope 	= auto_detect_scope(args.first)
				options = args[1] || {}
				options.reverse_merge!(
          :size => :large,
          :length => :short,
          :background => :white,
          :button => true,
          :autologoutlink => false,
					:perms => false
				).except!(:scope)
				text = options.delete(:text)
				begin
					url			= MiniFB.oauth_url(ENV['FB_APP_ID'], session_url(scope), :scope => options[:perms])
					options.merge!(
						:onlogin => "document.location.href = '#{url.to_s}'"
					)
					content_tag("fb:login-button", text, options)
					# content_tag(:div, text, options)
				rescue 
					error_message = "I think something gone wrong with #{scope.inspect} "
				end
			end
			
      protected

        # Auto-detect Devise scope using +Devise.default_scope+.
        # Used to make the link-helpers smart if - like in most cases -
        # only one devise scope will be used, e.g. "user" or "account".
        #
        def auto_detect_scope(*args)
          options = args.extract_options!

          if options.key?(:for)
            options[:scope] = options[:for]
            ::ActiveSupport::Deprecation.warn("DEPRECATION: " <<
              "Devise scope :for option is deprecated. " <<
              "Use: facebook_*_link(:some_scope), or facebook_*_link(:scope => :some_scope)")
          end

          scope = args.detect { |arg| arg.is_a?(Symbol) } || options[:scope] || ::Devise.default_scope
          mapping = ::Devise.mappings[scope]

          if mapping.for.include?(:facebook)
            scope
          else
            error_message =
              "%s" <<
              " Did you forget to devise facebook_connect in your model? Like this: devise :facebook_connectable." <<
              " You can also specify scope explicitly, e.g.: facebook_*link :for => :customer."
            error_message %=
              if scope.present?
                "#{scope.inspect} is not a valid facebook devise scope. " <<
                "Loaded modules for this scope: #{mapping.for.inspect}."
              else
                "Could not auto-detect any facebook_connectable devise scope."
              end
            raise error_message
          end
        end

        # Generate agnostic hidden sign in/out (connect) form for Facebook Connect.
        #
        def facebook_connect_form(scope, options = {})
          sign_out_form = options.delete(:sign_out)
          options.reverse_merge!(
              :id => (sign_out_form ? 'fb_connect_sign_out_form' : 'fb_connect_sign_in_form'),
              :style => 'display:none;'
            )
          scope = ::Devise::Mapping.find_by_path(request.path).name rescue scope
          url = sign_out_form ? destroy_session_path(scope) : session_path(scope)

          form_for(scope, :url => url, :html => options) { |f| }
        end
		end
	end
end
::ActionView::Base.send :include, Devise::Facebook::Helpers