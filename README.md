Related Products
================

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

        rt = RelationType.create(:name => "Accessories", :applies_to => "Product")
         => #<RelationType id: 4, name: "Accessories" ...>
        product = Product.last
         => #<Product id: 1060500592 ...>
        product.accessories
         => []

You can access all related products regardless of RelationType by:

        product.relations
         => []


Discounts
---------
If you install the spree-automatic-coupons extension you can also specify a discount amount to be applied if a customer purchases both products. Note: In order for the coupon to be automatically applied, you must create a coupon of type: __RelatedProductDiscount__ and leave the __code__ value empty (blank codes are required for coupons to be automatically applied).


Development
-----------

Run `rake test_app` to create the test application in `spec/test_app`.

`rake` will run the specs.
