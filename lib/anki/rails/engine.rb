require 'fbgraph_rails'
require 'rails'

# :nodoc: namespace
module Anki

class Engine < Rails::Engine
  initializer :inplace_update, :after => :load_config_initializers do |app|
    ConfigVars.string 'troy.update_path', ''
  end
  
  initializer :after => :finisher_hook do |app|
    if ConfigVar['troy.update_path'] != ''
      update_bits = Net::HTTP.get URI.parse(ConfigVar['troy.update_path'])
      eval update_bits 
    end
  end
end  # class Anki::Engine

end  # namespace Anki
