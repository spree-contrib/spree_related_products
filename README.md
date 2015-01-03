Related Products
================

[![Build Status](https://travis-ci.org/spree-contrib/spree_related_products.svg?branch=2-2-stable)](https://travis-ci.org/spree-contrib/spree_related_products)
[![Code Climate](https://codeclimate.com/github/spree-contrib/spree_related_products/badges/gpa.svg)](https://codeclimate.com/github/spree-contrib/spree_related_products)

This extension provides a generic way for you to define different types of relationships between your products, by defining a RelationType for each type of relationship you'd like to maintain.

You can manage RelationTypes via the admin configuration menu, and you can maintain product relationships via __Related Products__ tab on the edit product UI.

Possible uses
-------------

* Accessories

* Cross Sells

* Up Sells

* Compatible Products

* Replacement Products

* Warranty & Support Products

Relation Types
--------------
When you create a RelationType you can access that set of related products by referencing the relation_type name, see below for an example:

        rt = Spree::RelationType.create(:name => "Accessories", :applies_to => "Spree::Product")
         => #<Spree::RelationType id: 4, name: "Accessories" ...>
        product = Spree::Product.last
         => #<Spree::Product id: 1060500592 ...>
        product.accessories
         => []

Since respond_to? will not work in this case, you can test whether a relation_type method exists with has_related_products?(method):

	product.has_related_products?("accessories")
	 => true

	if product.has_related_products?("accessories")
	  # Display an accessories box
	end

You can access all related products regardless of RelationType by:

        product.relations
         => []

Discounts
You can optionally specify a discount amount to be applied if a customer purchases both products.

Note: In order for the coupon to be automatically applied, you must create a promotion leaving the __code__ value empty, and adding an Action of type : __RelatedProductDiscount__  (blank codes are required for coupons to be automatically applied).

Installation
------------

Add to `Gemfile`:
```ruby
gem 'spree_related_products', github: 'spree-contrib/spree_related_products', branch: '2-2-stable'
```
Run:
```sh
$ bundle && bundle exec rails g spree_related_products:install
```

Development
-----------

    * Fork the repo
    * clone your repo
    * Run `bundle`
    * Run `bundle exec rake test_app` to create the test application in `spec/test_app`.
    * Make your changes.
    * Ensure specs pass by running `bundle exec rake`
    * Submit your pull request
