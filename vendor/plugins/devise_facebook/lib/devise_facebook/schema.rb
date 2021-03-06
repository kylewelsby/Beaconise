# encoding: utf-8
require 'devise/schema'

module Devise #:nodoc:
  module Facebook #:nodoc:

    module Schema

      # Database migration schema for Facebook Connect.
      #
      def facebook
        apply_schema ::Devise.facebook_uid_field, Integer, :limit => 8  # BIGINT unsigned / 64-bit int
        apply_schema ::Devise.facebook_session_key_field, String, :limit => 149  # [128][1][20] chars
      end

    end
  end
end

Devise::Schema.module_eval do
  include ::Devise::Facebook::Schema
end
