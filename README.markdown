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



