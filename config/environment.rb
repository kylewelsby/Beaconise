RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # middleware
  %w(mailers middleware).each do |dir|
    config.load_paths << "#{RAILS_ROOT}/app/#{dir}" 
  end
  
  # config.gem 'mysql'
  config.gem 'searchlogic'
	config.gem 'formtastic', :source => 'http://gemcutter.org'
  config.gem 'meta-tags', :lib => 'meta_tags', :source => 'http://gemcutter.org'
	config.gem 'thoughtbot-paperclip', :lib => 'paperclip', :source => 'http://gems.github.com'
  config.gem 'mislav-will_paginate', :lib => 'will_paginate', :source => 'http://gems.github.com'
  config.gem "warden"
  config.gem "devise", :version => ">= 1.0.6"	
	# config.gem 'facebooker'
	# config.gem 'mini_fb', :version => ">= 1.0.3", :lib => 'mini_fb', :source => "http://gemcutter.org"
	# config.gem 'devise_facebook_connectable'
  # config.gem "vestal_versions"
	# config.gem "tenderlove-nokogiri", :lib => "nokogiri", :source => "http://gems.github.com"
	config.gem "tenderlove-mechanize", :lib => "mechanize", :source => "http://gems.github.com"
	config.gem "tobi-liquid", :lib => "liquid", :source => "http://gems.github.com"
	config.gem "geokit"
	config.gem "wizardly_gt", :lib => "wizardly"
	config.gem "musicbrainz_automatcher"
	config.gem "httparty"
	# config.gem "songkickr", :lib => "songkickr", :source => "http://gems.rubyforge.org/"

  config.time_zone = 'London'

end

ENV['FB_APP_ID'] 	= "128275153856809"
ENV['FB_API_KEY']	= "e8ac4c4b1065e7e29df9597df6bafcae"
ENV['FB_SECRET'] 	= "e5fc329e296dd138df42c954e319ca7b"

ENV['songkick_api'] = "kzCPLYG7RnEI3F53"