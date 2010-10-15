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
  # Array of fields.
  attr_reader :fields
  # Array of card models.
  attr_reader :card_models

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
    deck.fields = Field.from_db deck_db, deck
    deck.fields.each { |field| field.model.add_field field }
    deck.card_models = CardModel.from_db deck_db, deck
    deck.card_models.each { |cmodel| cmodel.model.add_card_model cmodel }
    
    deck
  end
  
  # :nodoc: private
  def initialize
    @models_by_id = {}
    @fields_by_id = {}
    @card_models_by_id = {}
  end
  
  # :nodoc: private
  def models=(new_models)
    @models = new_models
    @models_by_id = new_models.index_by(&:anki_id)
  end
  # :nodoc: private
  attr_reader :models_by_id
  
  # :nodoc: private
  def fields=(new_fields)
    @fields = new_fields
    @fields_by_id = new_fields.index_by(&:anki_id)
  end
  # :nodoc: private
  attr_reader :fields_by_id
  
  # :nodoc: private
  def card_models=(new_card_models)
    @card_models = new_card_models
    @card_models_by_id = new_card_models.index_by(&:anki_id)
  end
end  # class Anki::Importer::Deck
end  # namespace Anki::Importer
end  # namespace Anki
