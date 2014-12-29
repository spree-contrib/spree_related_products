describe Spree::Relation do
  context 'relations' do
    it { should belong_to(:relation_type) }
    it { should belong_to(:relatable) }
    it { should belong_to(:related_to) }
  end

  context 'validation' do
    it { should validate_presence_of(:relation_type) }
    it { should validate_presence_of(:relatable) }
    it { should validate_presence_of(:related_to) }
  end
end
