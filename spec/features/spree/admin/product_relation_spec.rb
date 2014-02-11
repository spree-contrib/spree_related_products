require 'spec_helper'

feature 'Admin Product Relation', js: true do
  stub_authorization!

  given!(:product) { create(:product) }
  given!(:other)   { create(:product) }

  given!(:relation_type) { create(:relation_type, name: 'Gears') }

  background do
    visit spree.edit_admin_product_path(product)
    click_link 'Related Products'
  end

  scenario 'create relation' do
    pending 'unable to select2_search product/other name'

    expect(page).to have_text 'Add Related Product'.upcase
    expect(page).to have_text product.name

    within('#add-line-item') do
      select2_search other.name, from: 'Name or SKU'
      select2_search relation_type.name, from: 'Type'
      fill_in 'add_discount', with: '0.8'
      click_link 'Add'
    end

    wait_for_ajax

    within_row(1) do
      expect(page).to have_field('relation_discount_amount', with: '0.8')
      expect(column_text(2)).to eq other.name
      expect(column_text(4)).to eq relation_type.name
    end
  end

  context 'with relations' do
    given!(:relation) do
      create(:relation, relatable: product, related_to: other, relation_type: relation_type, discount_amount: 0.5)
    end

    background do
      visit spree.edit_admin_product_path(product)
      click_link 'Related Products'
    end

    scenario 'ensure on content' do
      expect(page).to have_text 'Add Related Product'.upcase
      expect(page).to have_text product.name
      expect(page).to have_text other.name

      within_row(1) do
        expect(page).to have_field('relation_discount_amount', with: '0.5')
        expect(column_text(2)).to eq other.name
        expect(column_text(4)).to eq relation_type.name
      end
    end

    scenario 'update discount' do
      within_row(1) do
        fill_in 'relation_discount_amount', with: '0.9'
        click_on 'Update'
      end
      wait_for_ajax
      within_row(1) do
        expect(page).to have_field('relation_discount_amount', with: '0.9')
      end
    end

    scenario 'delete' do
      within_row(1) do
        click_icon :trash
      end
      wait_for_ajax
      expect(page).not_to have_text other.name
    end
  end
end