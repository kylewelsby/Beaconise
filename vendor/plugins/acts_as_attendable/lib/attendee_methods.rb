module ActsAsAttendable
  module Attendee
    
    def self.included(attendee_model)
      attendee_model.extend Finders
      attendee_model.named_scope :recent, {:order => "created_at DESC"}
      attendee_model.named_scope :limit, lambda {|limit| {:limit => limit} }
    end
    
    module Finders
      
      def find_attending_by_user(user)
        find(:all,
          :conditions => ["user_id = ?", user.id],
          :order => "created_at DESC"
        )
      end
      
      def find_attendees(attendable_type, attendable_id)
        find(:all,
          :conditions => ["attendable_type = ? and attendable_id = ?", attendable_type, attendable_id],
          :order => "created_at DESC"
        )
      end
      
      def find_attendable(attendable_type, attendable_id)
        attendable_type.constantize.find(attendable_id)
      end
      
    end
    
  end
end