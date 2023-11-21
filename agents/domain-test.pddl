(define (domain craft-bots)

    (:requirements :typing :fluents :negative-preconditions :strips)
    (:types actor location mine resource task edge - object)

    (:predicates
        (actorstate ?a - actor)
        (alocation ?a - actor ?l - location)
        (mlocation ?m - mine ?l - location)
        (rlocation ?r - resource ?l - location)
        (dlocation ?r - resource ?l - location)
        (connects ?start - location ?end - location ?e - edge)
        (mcolour ?m - mine ?r - resource)
        (available-site ?l - location ?t - task)
        (not-deposited ?a - actor ?r - resource ?l - location)
        (deposited ?a - actor ?r - resource ?l - location)
    )

    (:functions
        (needed_resources ?r - resource ?l - location ?t - task)
        (building_count ?t - task)
        (carrying ?a - actor ?r - resource)
    )

    (:action move
        :parameters (?a - actor ?start - location ?end - location ?e - edge)
        :precondition (and
            (actorstate ?a)
            (alocation ?a ?start)
            (connects ?start ?end ?e)
        )
        :effect (and
            (alocation ?a ?end) 
            (not (alocation ?a ?start))
        )
    )

    (:action pick-up
        :parameters (?a - actor ?l - location ?r - resource)
        :precondition (and 
            (actorstate ?a)
            (alocation ?a ?l)
            (rlocation ?r ?l)
            (<= (carrying ?a ?r) 7)
        )
        :effect (and 
            (increase (carrying ?a ?r) 1)
            (not(rlocation ?r ?l))
        )
    )

    ; (:action drop
    ;     :parameters (?a - actor ?l - location ?r - resource)
    ;     :precondition (and
    ;         (actorstate ?a)
    ;         (alocation ?a ?l)
    ;         (carry ?a ?r)
    ;     )
    ;     :effect (and 
    ;         (rlocation ?r ?l)
    ;         (decrease (carrying ?a ?r) 1)
    ;     )
    ; )
    
    (:action mine
        :parameters (?a - actor ?m - mine ?r - resource ?l - location)
        :precondition (and
            (actorstate ?a)
            (alocation ?a ?l) 
            (mcolour ?m ?r)
            (mlocation ?m ?l)
        )
        :effect (and 
            (rlocation ?r ?l)
        )
    )

    (:action start-building
        :parameters (?a - actor ?l - location ?t - task ?r - resource)
        :precondition (and
            (actorstate ?a)
            (alocation ?a ?l)
            (available-site ?l ?t)
        )
        :effect (and 
            (dlocation ?r ?l)
            (not(available-site ?l ?t))
        )
    )

    (:action deposit
        :parameters (?a - actor ?l - location ?r - resource)
        :precondition (and
            (actorstate ?a)
            (alocation ?a ?l)
            (dlocation ?r ?l)
            (>= (carrying ?a ?r) 1)
            (not-deposited ?a ?r ?l)
        )
        :effect (and
            (decrease (carrying ?a ?r) 1)
            (deposited ?a ?r ?l)
            (not(not-deposited ?a ?r ?l))
        )
    )
    
    (:action build
        :parameters (?a - actor ?l - location ?r - resource ?t - task)
        :precondition (and
            (actorstate ?a) 
            (alocation ?a ?l)
            (deposited ?a ?r ?l)
            (> (needed_resources ?r ?l ?t) 1)
        )
        :effect (and
            (decrease (needed_resources ?r ?l ?t) 1)
            (not (deposited ?a ?r ?l))
            (not-deposited ?a ?r ?l)
        )
    )

    (:action complete-building
        :parameters (?a - actor ?l - location ?r - resource ?t - task)
        :precondition (and
            (actorstate ?a) 
            (alocation ?a ?l)
            (deposited ?a ?r ?l)
            (= (needed_resources ?r ?l ?t) 1)
        )
        :effect (and
            (decrease (needed_resources ?r ?l ?t) 1)
            (not (deposited ?a ?r ?l))
            (not-deposited ?a ?r ?l)
            (increase (building_count ?t) 1)
        )
    )

    ; (:action complete-task
    ;     :parameters (?a - actor ?l - location ?r - resource ?t - task)
    ;     :precondition (and
    ;         (= (needed_resources ?r ?l ?t) 0)
    ;         (= (building_count ?t) 1)
    ;     )
    ;     :effect (and
    ;         (not(available-site ?l ?t))
    ;         (task-completed ?t)
    ;     )
    ; )

)