# Helper functions for debuging
class Debug
  # REQUIRE STATEMENT
  # require "#{Rails.root}/lib/debug.rb"
  def self.console(message)
    puts '*' * 20
    puts
    puts "LOCATION: #{caller(1,1)[0]}"
    puts 'Debug Console: ' + message.to_s
    puts
    puts '*' * 20
  end
end
