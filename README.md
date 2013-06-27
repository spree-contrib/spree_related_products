# Related Products

[![Build Status](https://secure.travis-ci.org/futhr/spree_related_products.png?branch=master)](http://travis-ci.org/futhr/spree_related_products)
[![Dependency Status](https://gemnasium.com/futhr/spree_related_products.png)](https://gemnasium.com/futhr/spree_related_products)
[![Coverage Status](https://coveralls.io/repos/futhr/spree_related_products/badge.png?branch=master)](https://coveralls.io/r/futhr/spree_related_products)

This extension provides a generic way for you to define different types of relationships between your products, by defining a RelationType for each type of relationship you'd like to maintain.

You can manage RelationTypes via the admin configuration menu, and you can maintain product relationships via __Related Products__ tab on the edit product UI.

## Possible uses

* Accessories
* Cross Sells
* Up Sells
* Compatible Products
* Replacement Products
* Warranty & Support Products

## Relation Types

When you create a RelationType you can access that set of related products by referencing the relation_type name, see below for an example:
```ruby
rt = Spree::RelationType.create(name => "Accessories", :applies_to => "Spree::Product")
 => #<Spree::RelationType id: 4, name: "Accessories" ...>
product = Spree::Product.last
 => #<Spree::Product id: 1060500592 ...>
product.accessories
 => []
```

You can access all related products regardless of RelationType by:
```ruby
product.relations
 => []
```

**Discounts**
You can optionally specify a discount amount to be applied if a customer purchases both products.

Note: In order for the coupon to be automatically applied, you must create a promotion leaving the __code__ value empty, and adding an Action of type : __RelatedProductDiscount__  (blank codes are required for coupons to be automatically applied).

## Installation

Add to `Gemfile`:
```ruby
gem 'spree_related_products', github: 'spree/spree_related_products'
```

Run:
```sh
$ bundle install
$ rails g spree_related_products:install
```

## Contributing

In the spirit of [free software][1], **everyone** is encouraged to help improve this project.

Here are some ways *you* can contribute:

* by using prerelease versions
* by reporting [bugs][2]
* by suggesting new features
* by writing or editing documentation
* by writing specifications
* by writing code (*no patch is too small*: fix typos, add comments, clean up inconsistent whitespace)
* by refactoring code
* by resolving [issues][2]
* by reviewing patches

Starting point:

* Fork the repo
* Clone your repo
* Run `bundle install`
* Run `bundle exec rake test_app` to create the test application in `spec/test_app`
* Make your changes
* Ensure specs pass by running `bundle exec rspec spec`
* Submit your pull request

Copyright (c) 2013 Brian Quinn, released under the [New BSD License][3]

[1]: http://www.fsf.org/licensing/essays/free-sw.html
[2]: https://github.com/spree/spree_related_products/issues
[3]: https://github.com/spree/spree_related_products/tree/master/LICENSE
