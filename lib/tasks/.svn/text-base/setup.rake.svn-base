namespace :devise do 
  desc "Setup Users and Admins"
  task :setup => ['db:drop','db:create', 'db:migrate','environment'] do
    user = User.create! do |u|
      u.username = "mekyle"
      u.email = "kyle@mekyle.com"
      u.forename = "Kyle"
      u.surname = "Welsby"
      u.born_on = "1987-06-12"
      u.female = false
      u.password = "password"
      u.password_confirmation = "password"
    end
    # user.confirm!
    puts "New user created!"
    puts "Email   : " << user.email
    puts "Password: " << user.password
    
    admin = Admin.create! do |a|
      a.email = "kyle@mekyle.com"
      a.password = "password"
      a.password_confirmation = "password"
    end
    puts "Created Admin!" if admin

		business = Business.create! do |b|
			b.email = "kyle@mekyle.com"
			b.password = "password"
			b.password_confirmation = "password"
		end
		puts "Created Business" if business
  end
end