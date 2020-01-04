connection: "postgres"

# include all the views
include: "/views/**/*.view"

datagroup: dvdrental_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: dvdrental_default_datagroup

#explore: actor {}

explore: actor {
  view_label: "Actor base"

  join: ninja {
    view_label: "Ninja two"
    from: actor
    relationship: one_to_one
    type: left_outer
    sql_on: ${actor.actor_id}=${ninja.actor_id} ;;
  }
}

explore: actor_info {
  join: actor {
    type: left_outer
    sql_on: ${actor_info.actor_id} = ${actor.actor_id} ;;
    relationship: many_to_one
  }
}

explore: address {
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
}

explore: category {}

explore: city {
  join: country {
    type: left_outer
    sql_on: ${city.country_id} = ${country.country_id} ;;
    relationship: many_to_one
  }
}

explore: country {}

explore: customer {
  join: address {
    type: left_outer
    sql_on: ${customer.address_id} = ${address.address_id} ;;
    relationship: many_to_one
  }

  join: store {
    type: left_outer
    sql_on: ${customer.store_id} = ${store.store_id} ;;
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
}

explore: customer_list {}

explore: film {
  join: language {
    type: left_outer
    sql_on: ${film.language_id} = ${language.language_id} ;;
    relationship: many_to_one
  }
}

explore: film_actor {
  join: film {
    type: left_outer
    sql_on: ${film_actor.film_id} = ${film.film_id} ;;
    relationship: many_to_one
  }

  join: actor {
    type: left_outer
    sql_on: ${film_actor.actor_id} = ${actor.actor_id} ;;
    relationship: many_to_one
  }

  join: language {
    type: left_outer
    sql_on: ${film.language_id} = ${language.language_id} ;;
    relationship: many_to_one
  }
}

explore: film_category {
  join: category {
    type: left_outer
    sql_on: ${film_category.category_id} = ${category.category_id} ;;
    relationship: many_to_one
  }

  join: film {
    type: left_outer
    sql_on: ${film_category.film_id} = ${film.film_id} ;;
    relationship: many_to_one
  }

  join: language {
    type: left_outer
    sql_on: ${film.language_id} = ${language.language_id} ;;
    relationship: many_to_one
  }
}

explore: film_list {}

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

explore: language {}

explore: nicer_but_slower_film_list {}

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

explore: rental {
  join: inventory {
    type: left_outer
    sql_on: ${rental.inventory_id} = ${inventory.inventory_id} ;;
    relationship: many_to_one
  }

  join: staff {
    type: left_outer
    sql_on: ${rental.staff_id} = ${staff.staff_id} ;;
    relationship: many_to_one
  }

  join: customer {
    type: left_outer
    sql_on: ${rental.customer_id} = ${customer.customer_id} ;;
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

explore: sales_by_film_category {}

explore: sales_by_store {}

explore: staff {
  join: store {
    type: left_outer
    sql_on: ${staff.store_id} = ${store.store_id} ;;
    relationship: many_to_one
  }

  join: address {
    type: left_outer
    sql_on: ${staff.address_id} = ${address.address_id} ;;
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
}

explore: staff_list {}

explore: store {
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
}
