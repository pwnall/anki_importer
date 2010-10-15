require 'sqlite3'

# :nodoc: namespace
module Anki
# :nodoc: namespace
module Importer

# Schema for Anki cards.
#
# A deck can have multiple models.
class Model
  # Name assigned in the Anki UI.
  attr_reader :name
  # Generally empty.
  attr_reader :description
  # Assigned in the Anki UI. Space-separated string.
  attr_reader :tags
  # Unique ID in the models table.
  attr_reader :anki_id
  
  # Fields belonging to this model.
  attr_reader :fields
  
  # Schema for cards based off this model.
  attr_reader :card_models
  
  # Reads the models from an Anki deck.
  #
  # Args:
  #   deck_db:: a Sqlite3::Datbase
  #
  # Returns an array of Model instances.
  def self.from_db(deck_db)
    query = 'SELECT id, name, description, tags, features FROM models'
    models = deck_db.execute(query).map do |anki_id, name, description, tags,
                                            features|
      self.new anki_id, name, description, tags, features
    end
  end
  
  # :nodoc: private
  def initialize(anki_id, name, description, tags, features)
    @anki_id = anki_id
    @name = name
    @description = description
    @tags = tags
    @features = features

    @fields = []
    @fields_by_id = {}
    @card_models = []
    @card_models_by_id = {}
  end
  
  # :nodoc: private
  def add_field(field)
    if @fields_by_id[field.anki_id]
      raise ArgumentError, 'The Field has a duplicate Anki ID.'
    end
    @fields << field
    @fields_by_id[field.anki_id] = field
  end  
  # :nodoc: private
  attr_reader :fields_by_id
  
  # :nodoc: private
  def add_card_model(card_model)
    if @card_models_by_id[card_model.anki_id]
      raise ArgumentError, 'The CardModel has a duplicate Anki ID.'
    end
    @card_models << card_model
    @card_models_by_id[card_model.anki_id] = card_model
  end
  # :nodoc: private
  attr_reader :card_models_by_id
end  # class Anki::Importer::Model
end  # namespace Anki::Importer
end  # namespace Anki
