(define (domain craft-bots)

    (:requirements :typing :fluents)
    (:types actor location mine resource task - object)

    (:predicates
        (alocation ?a - actor ?l - location)
        (mlocation ?m - mine ?l - location)
        (rlocation ?r - resource ?l - location)
        (connects ?start - location ?end - location)
        (not-carry ?a - actor ?r - resource)
        (carry ?a - actor ?r - resource)
        (mcolour ?m - mine ?r - resource)
        (not-occupied-site ?l - location)
        (occupied-site ?l - location)
        (not-deposited ?a - actor ?r - resource ?l - location)
        (deposited ?a - actor ?r - resource ?l - location)
    )

    (:functions
        (needed_resources ?r - resource ?l - location ?t - task)
    )

    (:action move
        :parameters (?a - actor ?start - location ?end - location)
        :precondition (and 
            (alocation ?a ?start)
            (connects ?start ?end)
        )
        :effect (and
            (alocation ?a ?end) 
            (not (alocation ?a ?start))
        )
    )

    (:action pick-up
        :parameters (?a - actor ?l - location ?r - resource)
        :precondition (and 
            (alocation ?a ?l)
            (rlocation ?r ?l)
            (not-carry ?a ?r)
        )
        :effect (and
            (carry ?a ?r)
            (not(not-carry ?a ?r))
            (not(rlocation ?r ?l))
        )
    )

    (:action drop
        :parameters (?a - actor ?l - location ?r - resource)
        :precondition (and 
            (alocation ?a ?l)
            (carry ?a ?r)
        )
        :effect (and 
            (rlocation ?r ?l)
            (not (carry ?a ?r))
            (not-carry ?a ?r)
        )
    )
    
    (:action mine
        :parameters (?a - actor ?m - mine ?r - resource ?l - location)
        :precondition (and 
            (alocation ?a ?l) 
            (mcolour ?m ?r)
            (mlocation ?m ?l)
        )
        :effect (and 
            (rlocation ?r ?l)
        )
    )

    (:action start-building
        :parameters (?a - actor ?l - location)
        :precondition (and
            (alocation ?a ?l)
            (not-occupied-site ?l)
        )
        :effect (and 
            (occupied-site ?l)
            (not(not-occupied-site ?l))
        )
    )

    (:action deposit
        :parameters (?a - actor ?l - location ?r - resource)
        :precondition (and 
            (alocation ?a ?l)
            (carry ?a ?r)
            (occupied-site ?l)

        )
        :effect (and 
            (not (carry ?a ?r))
            (not-carry ?a ?r)
            (deposited ?a ?r ?l)
            (not(not-deposited ?a ?r ?l))
        )
    )
    
    (:action complete-building
        :parameters (?a - actor ?l - location ?r - resource ?t - task)
        :precondition (and 
            (alocation ?a ?l)
            (deposited ?a ?r ?l)
            (> (needed_resources ?r ?l ?t) 0)
        )
        :effect (and
            (decrease (needed_resources ?r ?l ?t) 1)
            (not (deposited ?a ?r ?l))
            (not-deposited ?a ?r ?l)
        )
    )
    
)