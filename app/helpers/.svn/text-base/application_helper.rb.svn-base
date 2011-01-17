# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def display_current_sub_nav
    if request.request_uri.split('/')[3] == "events" and request.request_uri.split('/')[4]
      render :partial => "#{request.request_uri.split('/')[3].pluralize}/subnav" if defined?(@page_class)
    else
      render :partial => "#{request.request_uri.split('/')[1].pluralize}/subnav" if defined?(@page_class)
    end
  end
  
  def display_current_small_vcard
    if request.request_uri.split('/')[3] == "events" and request.request_uri.split('/')[4]
      render :partial => "#{request.request_uri.split('/')[3].pluralize}/subnav" if defined?(@page_class)
    else
      render :partial => "#{request.request_uri.split('/')[1].pluralize}/subnav" if defined?(@page_class)
    end
  end
  
  def current_section
    request.request_uri.split('/')[1].pluralize
  end
  
  def strip_zeros_from_date(marked_date_string)
    cleaned_string = marked_date_string.gsub('*0', '').gsub('*', '')
    return cleaned_string
  end
  
	def datetime_ago(date)
		timeago(date)
	end

  def timeago(date, time=true)
    return unless date
		result = ""
    d = Date.today
    case date.to_date
    when d
      if date.hour == Time.now.hour and date.to_time <= Time.now
        time_ago_in_words(date) + " ago"
      elsif date.hour == Time.now.hour and date.to_time > Time.now
        "in " + time_ago_in_words(date)
			else
				result = "<span class=\"day today\" title=\"#{date.day.ordinalize} %b %Y\">Today</span>"
      end
    when d.tomorrow
			result = "<span class=\"day tomorrow\" title=\"#{date.day.ordinalize} %b %Y\">Tomorrow</span>"
		when d.yesterday
			result = "<span class=\"day yesterday\" title=\"#{date.day.ordinalize} %b %Y\">Yesterday</span>"
		when d..(d + 7.days)
			result = date.strftime("<span class=\"day this\" title=\"#{date.day.ordinalize} %b %Y\">This %A</span>")
    else
			result = strip_zeros_from_date(date.strftime("<span class=\"day\">%A</span> <span class=\"date\">*%d<sup>#{date.day.ordinalize.gsub(/\d/,'')}</sup></span> <span class=\"month\">%b</span> <span class=\"year\">%Y</span>"))
    end
		if time
			result << strip_zeros_from_date(date.strftime(" <span class=\"time\">*%I:%M %p</span>"))
		end
		return result
  end
  
  def get_profile_picture(user, size = :thumb)
    default_photo = "/images/errors/missing_#{size}.jpg" 
    return default_photo if user.nil?
    if user.galleries.size > 0 and !user.galleries.find_by_profile_pictures(true).nil? and !user.galleries.find_by_profile_pictures(true).photos.first.nil?
      return user.galleries.find_by_profile_pictures(true).photos.first.photo(size) || default_photo  
    else
      return default_photo
    end
  end

	def songkick_event_link(id)
		link_to("SongKick", "http://www.songkick.com/concerts/#{id}")
	end
	def tilllate_event_link(id)
		link_to("TillLate", "http://uk.tilllate.com/en/event/#{id}")
	end
  
end
