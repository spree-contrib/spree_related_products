RSpec.feature 'Admin Product Relation', :js do
  stub_authorization!

  given!(:product) { create(:product) }
  given!(:other)   { create(:product) }

  given!(:relation_type) { create(:relation_type, name: 'Gears') }

  background do
    visit spree.edit_admin_product_path(product)
    click_link 'Related Products'
  end

  scenario 'create relation' do
    expect(page).to have_text 'Add Related Product'
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
      expect(column_text(3)).to eq relation_type.name
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

    scenario 'ensure content exist' do
      expect(page).to have_text 'Add Related Product'
      expect(page).to have_text product.name
      expect(page).to have_text other.name

      within_row(1) do
        expect(page).to have_field('relation_discount_amount', with: '0.5')
        expect(column_text(2)).to eq other.name
        expect(column_text(3)).to eq relation_type.name
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

    context 'delete' do
      scenario 'can remove records' do
        within_row(1) do
          expect(column_text(2)).to eq other.name
          click_icon :delete
        end
        page.driver.browser.switch_to.alert.accept unless Capybara.javascript_driver == :poltergeist
        wait_for_ajax
        expect(page).to have_text 'successfully removed!'
        expect(page).not_to have_text other.name
      end
    end
  end
end
