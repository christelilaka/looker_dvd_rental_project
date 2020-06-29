include: "/views/test/actor_test.view"

view: 1_1_film_actor_extended {

  extends: [actor_test]

  dimension: full_name_extended_only {
    sql: CONCAT(${first_name}, ${last_name}) ;;
  }
}
