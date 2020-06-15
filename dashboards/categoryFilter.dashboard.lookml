- dashboard: categoryFilter
  title: Test Dashboard
  layout: newspaper
  elements:
  - title: New Tile
    name: New Tile
    model: dvdrental
    explore: category
    type: table
    fields: [category.name, category.last_update_date]
    sorts: [category.last_update_date desc]
    limit: 500
    query_timezone: America/New_York
    listen:
      category name: category.select_category_name
    width: 8
    height: 9
  filters:
  - name: category name
    title: category name
    type: field_filter
    default_value: All
    model: dvdrental
    explore: category
    field: category.select_category_name
