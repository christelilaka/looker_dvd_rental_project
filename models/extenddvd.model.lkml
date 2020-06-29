connection: "postgres"

include: "/views/1_1_film_actor_extended.view.lkml"                # include all views in the views/ folder in this project

explore: extended_actor {
  view_name: 1_1_film_actor_extended
}
