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
  end
  
  describe 'Field' do
    let(:name_field) { deck.fields.find { |f| f.name == 'Color name' } }
    let(:code_field) { deck.fields.find { |f| f.name == 'HTML color code' } }
    let(:rgb_field) { deck.fields.find { |f| f.name == 'RGB color code' } }
  
    it 'should decode the name correctly' do
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
  end
end
