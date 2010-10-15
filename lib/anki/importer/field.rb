require 'sqlite3'

# :nodoc: namespace
module Anki
# :nodoc: namespace
module Importer

# Schema element for Anki facts.
#
# Each model has multiple fields. Each fact obeys the schema set by fields.
class Field
  # Name assigned in the Anki UI.
  attr_reader :name
  # Generally empty.
  attr_reader :description
  
  # True if no empty field values are allowed.
  attr_reader :required
  # True if all facts must have unique values for the field.
  attr_reader :unique
  # True if the field is a sort key (number to sort the cards by).
  attr_reader :numeric
  
  # Unique ID in the fields table.
  attr_reader :anki_id
  # The model that this field belongs to.  
  attr_reader :model
  
  # Reads the models from an Anki deck.
  #
  # Args:
  #   deck_db:: a Sqlite3::Datbase
  #   deck: the (under construction) Anki::Importer::Deck for deck_db
  #
  # Returns an array of Field instances.
  def self.from_db(deck_db, deck)
    query = 'SELECT id, modelId, name, description, features, required, "unique", numeric FROM fieldModels'
    models = deck_db.execute(query).map do |anki_id, model_id, name,
        description, features, required, unique, numeric|
      self.new anki_id, deck.models_by_id[model_id], name, description,
               features, required == 1, unique == 1, numeric == 1
    end
  end
  
  # :nodoc: private
  def initialize(anki_id, model, name, description, features, required, unique,
                 numeric)
    @anki_id = anki_id
    @model = model
    @name = name
    @description = description
    @features = features
    @required = required
    @unique = unique
    @numeric = numeric
  end
end  # class Anki::Importer::Model
end  # namespace Anki::Importer
end  # namespace Anki
