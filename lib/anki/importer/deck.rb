require 'active_support/core_ext'
require 'sqlite3'

# :nodoc: namespace
module Anki
# :nodoc: namespace
module Importer

# The root of the Anki object graph.
class Deck
  # Array of models.
  attr_reader :models

  # Reads an Anki deck database.
  #
  # Args:
  #   deck_path:: path to an Anki deck on the filesystem
  #
  # Returns a deck.  
  def self.from_file(deck_path)
    deck_db = SQLite3::Database.new deck_path
    from_db deck_db
  end
  
  # Reads an Anki deck database.
  #
  # Args:
  #   deck_db:: a Sqlite3::Datbase
  #
  # Returns a deck.
  def self.from_db(deck_db)
    deck = self.new
    deck.models = Model.from_db deck_db
    
    deck
  end
  
  # :nodoc: private
  def initialize
  end
  
  # :nodoc: private
  def models=(new_models)
    @models = new_models
    @models_by_id = new_models.index_by(&:anki_id)
  end
  # :nodoc: private
  attr_reader :models_by_id
end  # class Anki::Importer::Deck
end  # namespace Anki::Importer
end  # namespace Anki
