def system_and_log(message)
  gray = 37
  puts "\e[#{gray}m#{message}\e[0m"
  system message
end

def log(message)
  blue_color_code = 34
  puts "\e[#{blue_color_code}m#{message}\e[0m"
  system message
end