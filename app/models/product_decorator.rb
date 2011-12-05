Product.class_eval do
  has_many :relations, :as => :relatable

  def self.relation_types
    RelationType.find_all_by_applies_to(self.to_s, :order => :name)
  end

  def method_missing(method, *args)
    relation_type = nil
    begin
      relation_type =  self.class.relation_types.detect { |rt| rt.name.downcase.gsub(" ", "_").pluralize == method.to_s.downcase }
    rescue ActiveRecord::StatementInvalid => error
      # This exception is throw if the relation_types table does not exist. 
      # And this method is getting invoked during the execution of a migration 
      # from another extension when both are used in a project.
      relation_type = nil
    end

    # Fix for Ruby 1.9
    raise NoMethodError if method == :to_ary

    if relation_type.nil?
      super
    else
      relations.find_all_by_relation_type_id(relation_type.id).map(&:related_to).select do |product|
        product.deleted_at.nil? && product.available_on &&  product.available_on <= Time.now()
      end
    end

  end
end
