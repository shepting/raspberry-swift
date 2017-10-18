def system_and_log(message)
  gray = 37
  puts "\e[#{gray}m#{message}\e[0m"
  success = system message
  if success == false
    error "Failed to run command: " + message
    abort()
  end
end

def log(message)
  blue_color_code = 34
  puts "\e[#{blue_color_code}m#{message}\e[0m"
  system message
end

def error(message)
  red_color_code = 31
  puts "\e[#{red_color_code}m#{message}\e[0m"
  system message
end