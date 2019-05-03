# Helper functions for debuging in the console
class Debug
  def self.console(location, information)
    puts '*' * 20
    puts location + ': ' + information
    puts
    puts '*' * 20
  end
end
