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
    filters: {}
    sorts: [category.last_update_date desc]
    limit: 500
    query_timezone: America/New_York
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      category name: category.select_category_name
    row: 0
    col: 0
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
