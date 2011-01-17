class AttendanceGenerator < Rails::Generator::Base
   def manifest
     record do |m|
       m.directory 'app/models'
       m.file 'attendee.rb', 'app/models/attendee.rb'
       m.migration_template "create_attendees.rb", "db/migrate"
     end
   end
   # ick what a hack.
   def file_name
     "create_attendees"
   end
 end