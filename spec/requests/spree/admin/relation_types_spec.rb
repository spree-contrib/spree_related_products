require 'spec_helper'

describe "Manage Relation Types", :type => "controller" do
  stub_authorization!

  before(:each) do

    @relation_type = Spree::RelationType.create(name: "Benz", applies_to: "Spree::Product")
    @relation_type.save()

    @relation_type = Spree::RelationType.create(name: "BMW", applies_to: "Spree::Product")
    @relation_type.save()

    visit spree.admin_path
    click_link "Configuration"
    click_link "Manage Relation Types"

    # visit spree.admin_relation_types_path

  end

  context "create" do
    it "should be able to create a new relation type" do

      # create(:relation_type, :name => 'test', :applies_to => "Spree::Product")
      
      click_link "New Relation Type"

      fill_in "Name", :with => "bullock cart"
      fill_in "Applies To", :with => "Spree:Products"

      click_button "Create"

      page.should have_content("successfully created!")
      
      expect(current_path).to eql(spree.admin_relation_types_path)
    end

    it "should show validation errors with blank name" do
      click_link "New Relation Type"

      fill_in "Name", :with => ""
      click_button "Create"

      page.should have_content("Name can't be blank")
    end

    it "should show validation errors with blank applies_to" do
      click_link "New Relation Type"

      fill_in "Name", :with => "Test"
      fill_in "Applies To", :with => ""
      click_button "Create"

      page.should have_content("Applies To can't be blank")
    end

    it "should not create duplicate relation type" do
      @relation_type_first = Spree::RelationType.create(name: "My Test Type", applies_to: "Spree::Product")
      @relation_type_first.save()

      @relation_type_second = Spree::RelationType.create(name: "My Test Type", applies_to: "Spree::Product")
      @relation_type_second.should_not be_valid
    
    end

  end

  context "show" do
    it "should display existing relation types" do
      within_row(1) do
        column_text(1).should == "Benz"
        column_text(2).should == "Spree::Product"
        column_text(3).should == ""
      end
    end
  end
  
  context "edit" do
    before(:each) do
      within_row(1) { click_icon :edit }
    end

    it "should allow an admin to edit an existing relation type" do
      fill_in "Name", :with => "model 99"
      click_button "Update"
      page.should have_content("successfully updated!")
      page.should have_content("model 99")
    end

    # it "should show validation errors if there are any" do
    #   click_button "Update"
    #   page.should have_content("Name can't be blank")
    # end
  end

end