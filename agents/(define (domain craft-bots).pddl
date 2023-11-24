(define (domain craft-bots)

(:requirements :strips :typing :negative-preconditions :numeric-fluents :equality)
(:types actor node edge resource mine task)
	  
(:predicates
	(aloc ?a - actor ?n - node)
	(mloc ?m - mine ?n - node)
	(rloc ?r - resource ?n - node)
	(dloc ?r - resource ?n - node)
	(state ?a - actor)
	(available ?m - mine ?r - resource)
	(connected ?n1 - node ?n2 - node ?e - edge)
	(site ?n - node ?t - task)
	(drop ?a - actor ?r - resource ?n -node)
	(carry ?a - actor ?r - resource)
)
(:functions
	(carrying ?a - actor ?r - resource) - number
	(rdeposit ?n - node ?r - resource) - number
	(rfortask ?r - resource ?t - task)
	(carry_limit ?a - actor)
	(max_resources ?r - resource)
)
(:action move 
	:parameters (?a - actor ?n1 ?n2 - node ?e - edge)
	:precondition (and
		(state ?a)
		(aloc ?a ?n1)
		(connected ?n1 ?n2 ?e)
	)
	:effect(and
		(aloc ?a ?n2)
		(not (aloc ?a ?n1))
	)
)
(:action mine
	:parameters (?a - actor ?n - node ?m - mine ?r - resource)
	:precondition (and 
		(state ?a)
		(aloc ?a ?n)
		(mloc ?m ?n)
		(available ?m ?r)
		(>= (max_resources ?r) 1)
	) 
	:effect(and
		(rloc ?r ?n)
		(decrease (max_resources ?r) 1)
	)
)
(:action pick-up
	:parameters (?a - actor ?n - node ?r - resource)
	:precondition (and
		(state ?a)
		(aloc ?a ?n)
		(rloc ?r ?n)
		(<= (carry_limit ?a) 7)
	)
	:effect(and
		(increase (carrying ?a ?r) 1)
		(increase (carry_limit ?a) 1)
		(not (rloc ?r ?n))
		(carry ?a ?r)
	)
)
(:action drop
	:parameters (?a - actor ?r - resource ?n - node ?t - task)
	:precondition (and
		(state ?a)
		;(site ?n ?t)
		(aloc ?a ?n)
		(carry ?a ?r)
		(>= (carrying ?a ?r) 1)
		(>= (rdeposit ?n ?r) 1)
	)
	:effect (and
		(drop ?a ?r ?n)
		(decrease (carrying ?a ?r) 1)
		(decrease (carry_limit ?a) 1)
		(rloc ?r ?n)
		;(not (site ?n ?t))
		(not (carry ?a ?r))
	)
;	:parameters (?a - actor ?n - node ?t - task ?r - resource)
;	:precondition (and
;		(state ?a)
;		(aloc ?a ?n)
;		(site ?n ?t)
;		(carry ?a ?r)
;		;(>= (rfortask ?r ?t) 1)
;		(>= (rdeposit ?n ?r) 1)
;		(>= (carrying ?a ?r) 1)
;	)
;	:effect(and
;		(not (site ?n ?t))
;		
;		(dloc ?r ?n)
;	)
)
;(:action start-building
;	:parameters (?a - actor ?n - node ?r - resource ?t - task)
;	:precondition (and
;		(state ?a)
;		(aloc ?a ?n)
;		(drop ?a ?r ?n)
;		(rloc ?r ?n)
;		(>= (rfortask ?r ?t) 1)
;		(>= (rdeposit ?n ?r) 1)
;	)
;	:effect(and
;		(decrease (rfortask ?r ?t) 1)
;		(decrease (rdeposit ?n ?r) 1)
;		(not (drop ?a ?r ?n))
;		
;	)
;)
;(:action deposit 
;	:parameters (?a - actor ?r - resource ?n - node)
;	:precondition (and
;		(state ?a)
;		(aloc ?a ?n)
;		(>=(carrying ?a ?r) 1)
;	)
;	:effect(and
;		(decrease (carrying ?a ?r) 1)
;		(increase (rdeposit ?n ?r) 1)
;		(drop ?a ?r ?n)
;	)
;)
;(:action complete-task 
;	:parameters (?a - actor ?n - node ?r - resource ?t - task)
;	:precondition (and
;		(state ?a)
;		(aloc ?a ?n)
;		(drop ?a ?r ?n)
;		(= (rfortask ?r ?t) 1)
;		(= (rdeposit ?n ?r) 1)
;	)
;	:effect(and
;		(decrease (rfortask ?r ?t) 1)
;		(decrease (rdeposit ?n ?r) 1)
;		(not (drop ?a ?r ?n))
;	)
;)
(:action start-building-red
    :parameters (?a - actor ?n - node ?t - task ?r - resource)
    :precondition (and
        (state ?a)
        (aloc ?a ?n)
        (= ?r red)
        (>= (carrying ?a ?r) (rfortask ?r ?t))
    )
    :effect (and
        (decrease (rfortask ?r ?t) 1)
        (decrease (carrying ?a ?r) 1)
    )
)

(:action start-building-blue
    :parameters (?a - actor ?n - node ?t - task ?r - resource)
    :precondition (and
        (state ?a)
        (aloc ?a ?n)
        (= ?r blue)
        (>= (carrying ?a ?r) (rfortask ?r ?t))
    )
    :effect (and
        (decrease (rfortask ?r ?t) 1)
        (decrease (carrying ?a ?r) 1)
    )
)

(:action start-building-orange
    :parameters (?a - actor ?n - node ?t - task ?r - resource)
    :precondition (and
        (state ?a)
        (aloc ?a ?n)
        (= ?r orange)
        (>= (carrying ?a ?r) (rfortask ?r ?t))
    )
    :effect (and
        (decrease (rfortask ?r ?t) 1)
        (decrease (carrying ?a ?r) 1)
    )
)

(:action start-building-black
    :parameters (?a - actor ?n - node ?t - task ?r - resource)
    :precondition (and
        (state ?a)
        (aloc ?a ?n)
        (= ?r black)
        (>= (carrying ?a ?r) (rfortask ?r ?t))
    )
    :effect (and
        (decrease (rfortask ?r ?t) 1)
        (decrease (carrying ?a ?r) 1)
    )
)

(:action start-building-green
    :parameters (?a - actor ?n - node ?t - task ?r - resource)
    :precondition (and
        (state ?a)
        (aloc ?a ?n)
        (= ?r green)
        (>= (carrying ?a ?r) (rfortask ?r ?t))
    )
    :effect (and
        (decrease (rfortask ?r ?t) 1)
        (decrease (carrying ?a ?r) 1)
    )
)

)