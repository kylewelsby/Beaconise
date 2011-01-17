require 'nokogiri'
require 'open-uri'
require 'local_file'

module TillLateSite
	
	def self.included(base)
		base.extend ClassMethods
	end
	
	module ClassMethods
		def foo
			puts "Big explotion"
		end
	end
	
end
class TillLate
	include TillLateSite
end