describe Spree::RelationType do
  context 'relations' do
    it { should have_many(:relations).dependent(:destroy) }
  end

  context 'validation' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:applies_to) }
    it { should validate_uniqueness_of(:name).case_insensitive }

    it 'does not create duplicate names' do
      create(:relation_type, name: 'Gears')
      expect {
        create(:relation_type, name: 'gears')
      }.to raise_error
    end
  end
end
