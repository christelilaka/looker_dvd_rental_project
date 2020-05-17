connection: "postgres"

# include all the views
include: "/views/**/*.view"

datagroup: dvd_cache {
  sql_trigger: SELECT CURRENT_DATE ;;
  max_cache_age: "5 minutes"
}

datagroup: chat {
  sql_trigger: SELECT DATE_PART('day', NOW()) ;;
}



persist_with: dvd_cache

#explore: actor {}

map_layer: us_canada_region {
  file: "new_us_canada.topojson"
  property_key: "province"
}

explore: pdt__map {}

explore: customer {}

explore: 5_pdt_top_customer {
  sql_always_where:
                  {% if 5_pdt_top_customer.top_n._is_filtered %}
                      ${5_pdt_top_customer.is_ranked} = 'yes'
                  {% else %}
                      1=1
                  {% endif %};;
  join: customer {
    type: left_outer
    relationship: one_to_one
    sql_on: ${5_pdt_top_customer.customer_id}=${customer.customer_id} ;;
  }
}


explore: rental {
  sql_always_where:
                  {% if rental.namesearch._is_filtered %}
                      ${rental.filtered_name} = 'yes'
                  {% else %}
                      1=1
                  {% endif %} ;;
}





explore: rental_payment {
  from: payment
  join: rental {
    type: left_outer
    relationship: many_to_one
    sql_on: ${rental_payment.rental_id} = ${rental.rental_id} ;;
  }
}


explore: actor {
}



explore: payment {
  fields: [ALL_FIELDS*, -film_category.film_id, -film_category.category_id, -film_category.last_update_raw]
  join: rental {
    type: left_outer
    sql_on: ${payment.rental_id} = ${rental.rental_id} ;;
    relationship: many_to_one
  }

  join: customer {
    type: left_outer
    sql_on: ${payment.customer_id} = ${customer.customer_id} ;;
    relationship: many_to_one
  }

  join: staff {
    type: left_outer
    sql_on: ${payment.staff_id} = ${staff.staff_id} ;;
    relationship: many_to_one
  }

  join: inventory {
    type: left_outer
    sql_on: ${rental.inventory_id} = ${inventory.inventory_id} ;;
    relationship: many_to_one
  }

  join: store {
    type: left_outer
    sql_on: ${inventory.store_id} = ${store.store_id} ;;
    relationship: many_to_one
  }

  join: film {
    type: left_outer
    sql_on: ${inventory.film_id} = ${film.film_id} ;;
    relationship: many_to_one
  }

  join: film_category {
    type: left_outer
    sql_on: ${film.film_id} = ${film_category.film_id} ;;
    relationship: many_to_one
  }

  join: category {
    type: left_outer
    sql_on: ${film_category.category_id} = ${category.category_id} ;;
    relationship: many_to_one
  }

  join: pdt_ndt_top_10_category_rental {
    type: inner
    relationship: many_to_one
    sql_on: ${category.name} = ${pdt_ndt_top_10_category_rental.category_name} ;;
  }

  join: address {
    type: left_outer
    sql_on: ${store.address_id} = ${address.address_id} ;;
    relationship: many_to_one
  }

  join: city {
    type: left_outer
    sql_on: ${address.city_id} = ${city.city_id} ;;
    relationship: many_to_one
  }

  join: country {
    type: left_outer
    sql_on: ${city.country_id} = ${country.country_id} ;;
    relationship: many_to_one
  }

  join: language {
    type: left_outer
    sql_on: ${film.language_id} = ${language.language_id} ;;
    relationship: many_to_one
  }

  join: pdt_sort_category {
    type: left_outer
    sql_on: ${category.name} = ${pdt_sort_category.category} ;;
    relationship: many_to_one
  }

  join: pdt_moving_avg {
    type: left_outer
    relationship: one_to_one
    sql_on: ${payment.customer_id} = ${pdt_moving_avg.customer_id}
      AND ${payment.payment_date} = ${pdt_moving_avg.payment_date};;
  }
}


# explore: actor_info {
#   join: actor {
#     type: left_outer
#     sql_on: ${actor_info.actor_id} = ${actor.actor_id} ;;
#     relationship: many_to_one
#   }
# }

# explore: address {
#   join: city {
#     type: left_outer
#     sql_on: ${address.city_id} = ${city.city_id} ;;
#     relationship: many_to_one
#   }
#
#   join: country {
#     type: left_outer
#     sql_on: ${city.country_id} = ${country.country_id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: category {}
#
# explore: city {}
#
#
# explore: customer {
#   join: address {
#     type: left_outer
#     sql_on: ${customer.address_id} = ${address.address_id} ;;
#     relationship: many_to_one
#   }
#
#   join: store {
#     type: left_outer
#     sql_on: ${customer.store_id} = ${store.store_id} ;;
#     relationship: many_to_one
#   }
#
#   join: city {
#     type: left_outer
#     sql_on: ${address.city_id} = ${city.city_id} ;;
#     relationship: many_to_one
#   }
#
#   join: country {
#     type: left_outer
#     sql_on: ${city.country_id} = ${country.country_id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: customer_list {}
#
# explore: film {
#   join: language {
#     type: left_outer
#     sql_on: ${film.language_id} = ${language.language_id} ;;
#     relationship: many_to_one
#   }
# }
#
#
# # to put in the film_actor explore
# #join: actor {
#   #type: left_outer
#   #sql_on: ${film_actor.actor_id} = ${actor.actor_id} ;;
#  # relationship: many_to_one
# #}
#
# explore: film_actor {
#   label: "Film actor base"
#   view_name: film_actor
#   view_label: "Film Label Test"
#   join: film {
#     type: left_outer
#     sql_on: ${film_actor.film_id} = ${film.film_id} ;;
#     relationship: many_to_one
#   }
#   join: language {
#     type: left_outer
#     sql_on: ${film.language_id} = ${language.language_id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: extended_film_actor {
#   label: "Extended explore"
#   extends: [film_actor]
#   join: actor {
#     sql_on: ${film_actor.actor_id} = ${actor.actor_id};;
#     type: left_outer
#     relationship: many_to_one
#   }
# }
#
# #
#
#
#
#
#
# explore: film_category {
#   view_name: film_category
#   join: category {
#     type: left_outer
#     sql_on: ${film_category.category_id} = ${category.category_id} ;;
#     relationship: many_to_one
#   }
#
#   join: film {
#     type: left_outer
#     sql_on: ${film_category.film_id} = ${film.film_id} ;;
#     relationship: many_to_one
#   }
#
#   join: language {
#     type: left_outer
#     sql_on: ${film.language_id} = ${language.language_id} ;;
#     relationship: many_to_one
#   }
# }
#
# #explore: film_list {}
# explore: film_list {
# }

explore: inventory {
  join: store {
    type: left_outer
    sql_on: ${inventory.store_id} = ${store.store_id} ;;
    relationship: many_to_one
  }

  join: film {
    type: left_outer
    sql_on: ${inventory.film_id} = ${film.film_id} ;;
    relationship: many_to_one
  }

  join: address {
    type: left_outer
    sql_on: ${store.address_id} = ${address.address_id} ;;
    relationship: many_to_one
  }

  join: city {
    type: left_outer
    sql_on: ${address.city_id} = ${city.city_id} ;;
    relationship: many_to_one
  }

  join: country {
    type: left_outer
    sql_on: ${city.country_id} = ${country.country_id} ;;
    relationship: many_to_one
  }

  join: language {
    type: left_outer
    sql_on: ${film.language_id} = ${language.language_id} ;;
    relationship: many_to_one
  }
}

# explore: language {}
#
# explore: nicer_but_slower_film_list {}




# explore: rental {
#   join: inventory {
#     type: left_outer
#     sql_on: ${rental.inventory_id} = ${inventory.inventory_id} ;;
#     relationship: many_to_one
#   }
#
#   join: staff {
#     type: left_outer
#     sql_on: ${rental.staff_id} = ${staff.staff_id} ;;
#     relationship: many_to_one
#   }
#
#   join: customer {
#     type: left_outer
#     sql_on: ${rental.customer_id} = ${customer.customer_id} ;;
#     relationship: many_to_one
#   }
#
#   join: store {
#     type: left_outer
#     sql_on: ${inventory.store_id} = ${store.store_id} ;;
#     relationship: many_to_one
#   }
#
#   join: film {
#     type: left_outer
#     sql_on: ${inventory.film_id} = ${film.film_id} ;;
#     relationship: many_to_one
#   }
#
#   join: address {
#     type: left_outer
#     sql_on: ${store.address_id} = ${address.address_id} ;;
#     relationship: many_to_one
#   }
#
#   join: city {
#     type: left_outer
#     sql_on: ${address.city_id} = ${city.city_id} ;;
#     relationship: many_to_one
#   }
#
#   join: country {
#     type: left_outer
#     sql_on: ${city.country_id} = ${country.country_id} ;;
#     relationship: many_to_one
#   }
#
#   join: language {
#     type: left_outer
#     sql_on: ${film.language_id} = ${language.language_id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: sales_by_film_category {}
#
# explore: sales_by_store {}
#
# explore: staff {
#   join: store {
#     type: left_outer
#     sql_on: ${staff.store_id} = ${store.store_id} ;;
#     relationship: many_to_one
#   }
#
#   join: address {
#     type: left_outer
#     sql_on: ${staff.address_id} = ${address.address_id} ;;
#     relationship: many_to_one
#   }
#
#   join: city {
#     type: left_outer
#     sql_on: ${address.city_id} = ${city.city_id} ;;
#     relationship: many_to_one
#   }
#
#   join: country {
#     type: left_outer
#     sql_on: ${city.country_id} = ${country.country_id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: staff_list {}
#
# explore: store {
#   join: address {
#     type: left_outer
#     sql_on: ${store.address_id} = ${address.address_id} ;;
#     relationship: many_to_one
#   }
#
#   join: city {
#     type: left_outer
#     sql_on: ${address.city_id} = ${city.city_id} ;;
#     relationship: many_to_one
#   }
#
#   join: country {
#     type: left_outer
#     sql_on: ${city.country_id} = ${country.country_id} ;;
#     relationship: many_to_one
#   }
#}
