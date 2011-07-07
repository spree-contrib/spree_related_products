def valid_product(options={})
  defaults = { :name => "New Product",
               :price => 19.95,
               :available_on => 1.hour.ago
             }

  Product.new(defaults.merge(options))
end

def valid_product!(options={})
  p = valid_product(options)
  p.save!
  p
end
