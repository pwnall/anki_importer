# NOTE: can't do granular requires because active_support crashes
# require 'active_support/core_ext/enumerable'
# require 'active_support/core_ext/string'
require 'active_support/core_ext'
require 'sqlite3'

require 'anki/importer/card_model.rb'
require 'anki/importer/deck.rb'
require 'anki/importer/fact.rb'
require 'anki/importer/field.rb'
require 'anki/importer/model.rb'

require 'anki/rails/engine.rb'
