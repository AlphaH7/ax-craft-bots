(define (domain craftbots-simple)
    (:requirements :strips :typing :equality :negative-preconditions)

    ;; Types
    (:types actor node resource mine site task - object)

    ;; Predicates
    (:predicates
        (actor_at ?a - actor ?n - node)
        (resource_at ?r - resource ?n - node)
        (resource_in_inventory ?r - resource ?a - actor)
        (mine_at ?m - mine ?n - node)
        (site_at ?s - site ?n - node)
        (task_at ?t - task ?n - node)
        (task_completed ?t - task)
        (inventory_full ?a - actor))

    ;; Actions
    (:action move
        :parameters (?a - actor ?from - node ?to - node)
        :precondition (actor_at ?a ?from)
        :effect (and (not (actor_at ?a ?from)) (actor_at ?a ?to)))

    (:action pick_up_resource
        :parameters (?a - actor ?r - resource ?n - node)
        :precondition (and (actor_at ?a ?n) (resource_at ?r ?n) (not (inventory_full ?a)))
        :effect (and (not (resource_at ?r ?n)) (resource_in_inventory ?r ?a)))

    (:action drop_resource
        :parameters (?a - actor ?r - resource ?n - node)
        :precondition (and (actor_at ?a ?n) (resource_in_inventory ?r ?a))
        :effect (and (not (resource_in_inventory ?r ?a)) (resource_at ?r ?n)))

    (:action dig_at_mine
        :parameters (?a - actor ?m - mine ?n - node ?r - resource)
        :precondition (and (actor_at ?a ?n) (mine_at ?m ?n) (not (inventory_full ?a)))
        :effect (resource_at ?r ?n))

    (:action start_construction
        :parameters (?a - actor ?s - site ?n - node ?t - task)
        :precondition (and (actor_at ?a ?n) (site_at ?s ?n) (task_at ?t ?n))
        :effect (task_completed ?t))
)
