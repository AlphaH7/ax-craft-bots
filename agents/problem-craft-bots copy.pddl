(define (problem craftbots-simple) (:domain craftbots)
    (:objects
        loc1 loc2 loc3 loc4 loc5 loc6 loc7 loc8 loc9 loc10 - location
        actor1 actor2 actor3 - actor
        red green blue black orange - resource
        building1 building2 building3 - building
    )

    (:init
        ;; Actor locations
        (at actor1 loc1)
        (at actor2 loc2)
        (at actor3 loc3)

        ;; Location connections
        ;; (Define all connections between locations as per your simulation setup)

        ;; Resource locations
        (resource-available red loc4)
        (resource-available green loc5)
        (resource-available blue loc6)
        (resource-available black loc7)
        (resource-available orange loc8)

        ;; Building requirements
        (requires building1 red)
        (requires building2 green)
        (requires building3 blue)
    )

    (:goal (and
        (construction-completed building1)
        (construction-completed building2)
        (construction-completed building3)
    ))
)
