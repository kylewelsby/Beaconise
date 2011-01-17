namespace :venues do 
  desc "Setup Venues"
	task :setup => ['environment'] do
		
		venue = Venue.create! do |v|
			# v.business = business
			v.name = "de.bees Music Bar"
			v.address1 = "5-7 Market Place"
			v.city = "Winsford"
			v.county = "County"
			v.country = "United Kingdom"
			v.postcode = "CW7 3DA"
			v.website = "http://www.debees.com"
			v.email = "info@debees.com"
			v.telephone = "+441606558596"
		end
		puts "Created Venue" if venue
	
		venue2 = Venue.create! do |v|
			# v.business = business
			v.name = "Fabric"
			v.address1 = "77a Charterhouse Street"
			v.city = "London"
			v.country = "United Kingdom"
			v.postcode = "EC1M 3HN"
			v.website = "http://www.fabriclondon.com"
			v.telephone = "+441073368898"
		end
		puts "Created Venue" if venue2
	
		venue3 = Venue.create! do |v|
			# v.business = business
			v.name = "Couture & Noir et Blanc"
			v.address1 = "139 Newport Road"
			v.city = "Stafford"
			v.county = "Staffordshire"
			v.country = "United Kingdom"
			v.postcode = "ST16 2EZ"
			v.website = "http://www.coutureleisure.com/"
			v.telephone = "+441785244755"
		end
		puts "Created Venue" if venue3
	
		venue4 = Venue.create! do |v|
			# v.business = business
			v.name = "Matter"
			v.address1 = "The O2 Arena"
			v.address2 = "Peninsula Square, Greenwich"
			v.city = "London"
			v.country = "United Kingdom"
			v.postcode = "SE10 0DY"
			v.website = "http://www.matterlondon.com/"
			v.telephone = "+442075496686"
		end
		puts "Created Venue" if venue4
	end
end