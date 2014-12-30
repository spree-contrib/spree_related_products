RSpec.describe Spree::Relation, type: :model do
  context 'relations' do
    it { is_expected.to belong_to(:relation_type) }
    it { is_expected.to belong_to(:relatable) }
    it { is_expected.to belong_to(:related_to) }
  end

  context 'validation' do
    it { is_expected.to validate_presence_of(:relation_type) }
    it { is_expected.to validate_presence_of(:relatable) }
    it { is_expected.to validate_presence_of(:related_to) }
  end
end
