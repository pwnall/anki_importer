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
  end
end  # class Anki::Importer::Model
end  # namespace Anki::Importer
end  # namespace Anki
