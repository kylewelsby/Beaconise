Given /^the following venue_syncs:$/ do |venue_syncs|
  VenueSync.create!(venue_syncs.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) venue_sync$/ do |pos|
  visit venue_syncs_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following venue_syncs:$/ do |expected_venue_syncs_table|
  expected_venue_syncs_table.diff!(tableish('table tr', 'td,th'))
end
