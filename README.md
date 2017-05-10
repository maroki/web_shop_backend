# README

This is backend API application for a simple on-line shop which contains product catalog and shopping basket.

* Product catalog contains at least names, amounts for sale (i.e. stock) and prices of available products.

* Shopping basket contains products from the catalog and to-­be-­purchased amounts.

## On this app you can:
1. Adding/removing/editing products in product catalog
2. Adding/removing/editing products in shopping basket
3. Querying products from product catalog with basic pagination (10 products/query), sorted by given sorting key (name or price).
4. Querying products from the product catalog, grouped by price ranges.
5. Searching product from the catalog by matching the beginning of product name, filtering the
results within given price range (min, max), and sorting by given key (name or price).

Environment

* Ruby 2.3.0
* PostgreSQL

Installing and running


```

git clone https://github.com/maroki/web_shop_backend.git
cd web_shop_backend
bundle install
# set username and password in config/database.yml file
rake db:setup
rake db:test:prepare
rspec
rails s
```
