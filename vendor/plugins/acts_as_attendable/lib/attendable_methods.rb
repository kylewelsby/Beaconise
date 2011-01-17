require 'active_record'

module MeKyle
  module Acts #:nodoc:
    module Attendable #:nodoc:
      
      def self.include(base)
        base.extend ClassMethods
      end
      
      module ClassMethods
        def acts_as_attendable
          has_many :attendees, :as => :attendable, :dependent => :destroy
          include MeKyle::Acts::Attendable::InstanceMethods
          extend MeKyle::Acts::Attendable::SingletonMethods
        end
      end
      
      module SingletonMethods
        # Helper method to look up for attendees for a given object
        # This method is equivalent to obj.attendees
        def find_attendees(obj)
          attendable = ActiveRecord::Base.send(:class_name_of_active_record_descendant, self).to_s

          Attendee.find(:all,
            :conditions => ["attendable_id = ? and attendable_type = ?", obj.id, attendable],
            :order => "created_at DESC"
          )
        end
        
        # Helper class method to lookup attending by a given user
        def find_attending_by_user(user)
          attendable = ActiveRecord::Base.send(:class_name_of_active_record_descendant, self).to_s
          
          Attendee.find(:all,
            :conditions => ["user_id = ? and attendable_type = ?", user.id, attendable],
            :order => "created_at DESC"
          )
        end
      end
      
      module InstanceMethods
        def add_attendee(attendee)
          attendees << attendee
        end
      end
      
    end
  end
end

ActiveRecord::Base.send(:include, MeKyle::Acts::Attendable)
