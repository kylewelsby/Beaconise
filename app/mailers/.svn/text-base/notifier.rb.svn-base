class Notifier < ActionMailer::Base
  layout 'user_email'
  
  def password_reset_instructions(user, sent_at = Time.now)
    subject    'Beaconise Password Reset Instructions'
    recipients user.email
    from       'noreply@beaconise.com'
    sent_on    sent_at
    
    body       :reset_url => edit_user_password_url(user.perishable_token)
  end

  def welcome(user, sent_at = Time.now)
    subject    'Welcome to Beaconise'
    recipients user.email
    from       'noreply@beaconise.com'
    sent_on    sent_at
    
    body       :greeting => 'Hi,'
  end

  def suspended(user, sent_at = Time.now)
    subject     "Your Beaconise account has been Canceled"
    recipients  user.email
    from        "noreply@beaconise.com"
    sent_on     sent_at
  end
  
  def goodbye(user, sent_at = Time.now)
    subject     "Goodbye from Beaconise"
    recipients  user.email
    from        "noreply@beaconise.com"
    sent_on     sent_at
  end
end
