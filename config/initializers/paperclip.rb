# Paperclip.options[:command_path] = "/usr/local/bin"
Paperclip.options[:command_path] = "/usr/local/bin" if RAILS_ENV == "development"
# Paperclip.options[:log_command] = true