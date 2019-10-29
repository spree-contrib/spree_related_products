RSpec.describe Spree::RelationType, type: :model do
  context 'relations' do
    it { is_expected.to have_many(:relations).dependent(:destroy) }
  end

  context 'validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:applies_to) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }

    it 'does not create duplicate names' do
      create(:relation_type, name: 'Gears')
      expect {
        create(:relation_type, name: 'gears')
      }.to raise_error(ActiveRecord::RecordInvalid,'Validation failed: Name has already been taken')
    end
  end
end
