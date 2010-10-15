require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "anki-importer" do
  let(:deck) do
    deck_path = File.join File.dirname(__FILE__), 'fixtures', 'deck.anki'
    Anki::Importer::Deck.from_file deck_path
  end
  
  describe 'Deck' do
    it 'should have a Model' do
      deck.should have(1).model
    end
    
    it 'should have Fields' do
      deck.should have(3).fields
    end
    
    it 'should have CardModels' do
      deck.should have(3).card_models
    end
  end
  
  let(:model) { deck.models.first }
  
  describe 'Model' do
    it 'should extract the name correctly' do
      model.name.should == 'CSS Color'
    end
    
    it 'should extract tags correctly' do
      model.tags.should == 'css html color'
    end
    
    it 'should be associated with fields' do
      model.should have(3).fields
    end
    
    it 'should be associated with card models' do
      model.should have(3).card_models
    end
  end
  
  let(:name_field) { deck.fields.find { |f| f.name == 'Color name' } }
  let(:code_field) { deck.fields.find { |f| f.name == 'HTML color code' } }
  let(:rgb_field) { deck.fields.find { |f| f.name == 'RGB color code' } }

  describe 'Field' do  
    it 'should decode names correctly' do
      name_field.should_not be_nil
      code_field.should_not be_nil
      rgb_field.should_not be_nil
    end
    
    it 'should be associated with the right model' do
      name_field.model.should == model
    end
    
    it 'should decode required correctly' do
      name_field.required.should be_true
      rgb_field.required.should be_false
    end

    it 'should decode unique correctly' do
      name_field.unique.should be_false
      code_field.unique.should be_true
    end

    it 'should decode numeric correctly' do
      name_field.numeric.should be_false
    end
    
    it 'should order fields correctly' do
      model.fields.should == [name_field, code_field, rgb_field]
    end
  end
  
  let(:front_cm) { deck.card_models.find { |cm| cm.name == 'Name to code' } }
  let(:back_cm) { deck.card_models.find { |cm| cm.name == 'Code to name' } }
  let(:disabled_cm) do
    deck.card_models.find { |cm| cm.name == 'Disabled card' }
  end  
  describe 'CardModel' do
    it 'should decode names correctly' do
      front_cm.should_not be_nil
      back_cm.should_not be_nil
      disabled_cm.should_not be_nil
    end
    
    it 'should decode active' do
      front_cm.active.should be_true
      disabled_cm.active.should be_false
    end
    
    it 'should decode the question template' do
      front_cm.question_template.should == '%(Color name)s'
    end

    it 'should decode the answer template' do
      front_cm.answer_template.should == '%(HTML color code)s'
    end

    it 'should decode question formatting' do
      golden = { :font_family => 'Arial', :font_size => 20,
                 :color => '#000000', :text_align => 0 }
      front_cm.question_style.should == golden
    end

    it 'should decode answer formatting' do
      golden = { :font_family => 'Arial', :font_size => 20,
                 :color => '#000000', :text_align => 0 }
      front_cm.answer_style.should == golden
    end

    it 'should associate the answer field correctly' do
      front_cm.answer_field.should == code_field
      back_cm.answer_field.should be_nil
    end

    it 'should order models correctly' do
      model.card_models.should == [front_cm, back_cm, disabled_cm]
    end
  end
end
