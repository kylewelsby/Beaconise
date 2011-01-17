module UsersHelper
  def user_age(date)
    return "I forgotten my age" if date.nil?
    if Date.today.day == date.day && Date.today.month == date.month
      "It's my #{(Date.today.year - date.year).ordinalize} Birthday"
    else
      "#{Date.today.year - date.year} years"
    end
  end
  
  def gender?(user, img = true)
    if user.female
      "#{image_tag("famfamfam-icons/female.png") + " " if img}female"
    else
      "#{image_tag("famfamfam-icons/male.png") + " " if img}male"
    end
  end
  
  def online?(user)
    if !user.current_sign_in_at.nil? and user.current_sign_in_at >= 10.minutes.ago
      "#{image_tag("famfamfam-icons/bullet_green.png")} Online"
    else
      "#{image_tag("famfamfam-icons/bullet_white.png")} Offline"
    end
  end
  
  def get_profile_name(user)
    user.login || '<span class="user_unknown">Unknown</span>'
  end

  def self.user_path(user)
    user_path(user) || ""
  end
  
  def profile_picture_path(user)
    if user.galleries.find_by_profile_pictures(true)
      return user_gallery_path(@user.permalink, @user.galleries.find_by_profile_pictures(true).permalink)
    else
      return user_galleries_path(@user.permalink)
    end
  end
end
