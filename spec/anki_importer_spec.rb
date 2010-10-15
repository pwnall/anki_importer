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
  
  describe 'Model' do
    let(:model) { deck.models.first }

    it 'should extract the name correctly' do
      model.name.should == 'CSS Color'
    end
    
    it 'should extract tags correctly' do
      model.tags.should == 'css html color'
    end
  end
end
