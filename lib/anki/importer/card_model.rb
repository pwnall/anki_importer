# :nodoc: namespace
module Anki
# :nodoc: namespace
module Importer

# Schema for Anki cards.
#
# Each model has multiple card models, and card is generated by exactly one
# model, from one fact.
class CardModel
  # Name assigned in the Anki UI.
  attr_reader :name
  # Generally empty.
  attr_reader :description
  
  # True if the model is cards are generated based on this model. 
  attr_reader :active
  
  # Shown during the query stage and maybe during the answer stage.
  #
  # %(field_name)s inlines field values.
  attr_reader :question_template
  
  # Shown during the answer stage.
  #
  # %(field_name)s inlines field values. This isn't necessarily related what the
  # user's answer is verified against.
  attr_reader :answer_template
  
  # Hash with the following keys: :font_family, :font_size, :color, :text_align.
  attr_reader :question_style

  # Hash with the following keys: :font_family, :font_size, :color, :text_align.
  attr_reader :answer_style
    
  # If true, the question is showed in the answer stage.
  #
  # Otherwise, the answer presumably contains the question.
  attr_reader :question_in_answer
  
  # The field that the user's answer is checked against.
  #
  # If this is true, the user is asked to type an answer in the query stage, and
  # their answer is checked against the field value here.
  attr_reader :answer_field
  
  # Unique ID in the fields table.
  attr_reader :anki_id
  # The model that this field belongs to.  
  attr_reader :model
  
  # Reads the card models from an Anki deck.
  #
  # Args:
  #   deck_db:: a Sqlite3::Datbase
  #   deck: the (under construction) Anki::Importer::Deck for deck_db
  #
  # Returns an array of Field instances.
  def self.from_db(deck_db, deck)
    query = 'SELECT id, modelId, name, description, active, qformat, aformat, questionInAnswer, questionFontFamily, questionFontSize, questionFontColour, questionAlign, answerFontFamily, answerFontSize, answerFontColour, answerAlign, typeAnswer FROM cardModels ORDER BY ordinal'
    models = deck_db.execute(query).map do |anki_id, model_id, name,
        description, active, question_template, answer_template,
        question_in_answer, question_font_family, question_font_size,
        question_font_color, question_align, answer_font_family,
        answer_font_size, answer_font_color, answer_align, answer_field_name|
      
      model = deck.models_by_id[model_id]
      question_style = { :font_family => question_font_family,
          :font_size => question_font_size, :color => question_font_color,
          :text_align => question_align }
      answer_style = { :font_family => answer_font_family,
          :font_size => answer_font_size, :color => answer_font_color,
          :text_align => answer_align }
      answer_field = model.fields.find { |f| f.name == answer_field_name }
      
      self.new anki_id, model, name, description, active == 1,
               question_template, answer_template, question_style, answer_style,
               answer_field
    end
  end
  
  # :nodoc: private
  def initialize(anki_id, model, name, description, active, question_template,
                 answer_template, question_style, answer_style, answer_field)
    @anki_id = anki_id
    @model = model
    @name = name
    @description = description
    @active = active
    @question_template = question_template
    @answer_template = answer_template
    @question_style = question_style
    @answer_style = answer_style
    @answer_field = answer_field
  end
end  # class Anki::Importer::CardModel
end  # namespace Anki::Importer
end  # namespace Anki
