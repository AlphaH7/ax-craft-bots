(define (domain craft-bots)
    (:requirements :strips :typing)

    ;; Define types
    (:types
        actor
        location
        resource
        task
        building
    )

    ;; Define predicates
    (:predicates
        (at ?actor - actor ?location - location)
        (resource-at ?resource - resource ?location - location)
        (carrying ?actor - actor ?resource - resource)
        (task-at ?task - task ?location - location)
        (building-at ?building - building ?location - location)
        (needs ?task - task ?resource - resource)
        (completed ?task - task)
        (construction-started ?building - building)
        (construction-completed ?building - building)
    )

    ;; Actions
    (:action move
        :parameters (?actor - actor ?from - location ?to - location)
        :precondition (at ?actor ?from)
        :effect (and
                    (not (at ?actor ?from))
                    (at ?actor ?to))
    )

    (:action pick-up
        :parameters (?actor - actor ?resource - resource ?location - location)
        :precondition (and
                        (at ?actor ?location)
                        (resource-at ?resource ?location))
        :effect (and
                    (not (resource-at ?resource ?location))
                    (carrying ?actor ?resource))
    )

    (:action drop
        :parameters (?actor - actor ?resource - resource)
        :precondition (carrying ?actor ?resource)
        :effect (not (carrying ?actor ?resource))
    )

    (:action start-construction
        :parameters (?actor - actor ?building - building ?location - location)
        :precondition (and
                        (at ?actor ?location)
                        (building-at ?building ?location))
        :effect (construction-started ?building)
    )

    (:action deposit
        :parameters (?actor - actor ?resource - resource ?building - building)
        :precondition (and
                        (carrying ?actor ?resource)
                        (construction-started ?building))
        :effect (not (carrying ?actor ?resource))
        ;; Additional effects may be needed based on simulation rules
    )

    (:action complete-construction
        :parameters (?actor - actor ?building - building)
        :precondition (and
                        (construction-started ?building)
                        ;; Add other preconditions based on simulation rules
                      )
        :effect (construction-completed ?building)
    )

    ;; Add any other necessary actions...
)
