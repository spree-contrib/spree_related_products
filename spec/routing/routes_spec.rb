require 'spec_helper'

describe Spree::Admin::RelationTypesController do

  it 'routes GET /relation_types to relation types, index' do
  	# expect(current_path).to eql(spree.new_admin_relation_type_path)
    # {:get => spree.admin_relation_types_path}.should route_to(:controller=> 'spree/admin/relation_types', :action => 'index')
  end

#   it 'routes GET /relation_types/new to relation types, new' do
#     {:get => '/admin/relation_types/new'}.should route_to(:controller=> 'spree/admin/relation_types', :action => 'new')
#   end

#   it 'routes GET /relation_types/15 to relation types, show' do
#     {:get => '/admin/relation_types/15'}.should route_to(:controller=> 'relation_types', :action => 'show', :id => '15')
#   end

#   it 'routes GET /relation_types/15/edit to relation types, edit' do
#     {:get => '/admin/relation_types/15/edit'}.should route_to(:controller=> 'relation_types', :action => 'edit', :id => '15')
#   end

#   it 'routes POST /relation_types to relation types, create' do
#     {:post => '/admin/relation_types'}.should route_to(:controller=> 'relation_types', :action => 'create')
#   end
# end

# describe Spree::Admin::RelationsController do

#   it 'routes GET /relations to relation, index' do
#     {:get => '/relations'}.should route_to(:controller=> 'relations', :action => 'index')
#   end

#   it 'routes GET /relations/15 to relation, show' do
#     {:get => '/relations/15'}.should route_to(:controller=> 'relations', :action => 'show', :id => '15')
#   end
end