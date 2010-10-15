# :nodoc: namespace
module Anki
# :nodoc: namespace
module Importer

# An association tested by flash cards.
class Fact
  # Assigned in the Anki UI. Space-separated string.
  attr_reader :tags
  # Fact creation time.
  attr_reader :created_at
  # Fact modification time.
  attr_reader :modified_at

  # Maps Fields with their values.
  attr_reader :fields
  
  # Unique ID in the facts table.
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
    fact_query = 'SELECT id, modelId, tags, created, modified FROM facts'
    facts = deck_db.execute(fact_query).map do |anki_id, model_id, tags,
                                                t_created, t_modified|
      self.new anki_id, deck.models_by_id[model_id], tags, Time.at(t_created),
               Time.at(t_modified)
    end
    facts_by_id = facts.index_by(&:anki_id)
    
    field = 'SELECT factId, fieldModelId, value FROM fields'
    deck_db.execute(field) do |fact_id, field_model_id, value|
      fact = facts_by_id[fact_id]
      field = deck.fields_by_id[field_model_id]
      fact.fields[field] = value
    end
    facts
  end
  
  # :nodoc: private
  def initialize(anki_id, model, tags, created_at, modified_at)
    @anki_id = anki_id
    @model = model
    @tags = tags
    @created_at = created_at
    @modified_at = modified_at
    @fields = {}
  end
end  # class Anki::Importer::Field
end  # namespace Anki::Importer
end  # namespace Anki
