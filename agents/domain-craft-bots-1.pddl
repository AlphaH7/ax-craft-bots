(define (domain craft-bots)

    (:requirements :typing :numeric-fluents :equality :fluents)
    (:types
        node actor mine resource task
    )

    (:predicates
        ;; --nodes-- 
        (nodestate ?node1 - node)
        ;; --actor --
        ;;the actor is running
        (actorstate ?actor1 - actor)
        ;;location of actor
        (actorlocation ?actor1 - actor ?node1 - node)
        ;;whether the actor is carrying a resource
        (hasresource ?actor1 - actor)
        (nothasresource ?actor1 - actor)

        ;; -- mine -- 
        ;; mine location and mines with resource coulour
        (mine ?mine1 - mine)
        (minelocation ?mine1 - mine ?node1 - node)
        (mineresource ?mine1 - mine ?resource1 - resource)
        
        ;;resources for each mine
        (resource ?resource1 - resource)
    
        ;; --resource--
        ;;where is a resource located
        (resourceheld ?resource1 - resource ?actor1 - actor)

        ;; -- tasks -- 
        ;;task is activetask
        (taskactive ?task1 - task)
        ;(completedtask ?task1 - task)
        (targetsite ?task1 - task ?node1 - node)
        (taskinactive ?task1 - task)
        (taskcompleted ?task1 - task)

        ;;construction
        (siteat ?node - node)
        (nositeat ?node - node)
    
                ;;connecting nodes
        (connection ?nodea - node ?nodeb - node)
    )


    (:functions
        ;(neededresource ?task1 -task ?resource1 - resource)
        ;;keeps track of number of resources needed for a given task
        (number-resources-needed ?task1 - task)
        (node-resources ?node1 - node ?resource1 - resource)
        (holding-resource ?actor1 - actor)
        (todo-tasks ?actor1 - actor)
    )

    


    ;;move the actor
    (:action move 
        :parameters (?actor - actor ?nodea - node ?nodeb - node)
        :precondition (and 
            ;;actor is active
            (actorstate ?actor)
            ;;current location of the actor
            (actorlocation ?actor ?nodea)
            ;;there is a connection between the nodes
            (connection ?nodea ?nodeb)
        )
        :effect (and 
            (not(actorlocation ?actor ?nodea))
            (actorlocation ?actor ?nodeb)
         )
    )

    ;;pick up resource
    ;;Inputs actor, mine, resource, node
    (:action mining
        :parameters (?actor - actor ?mine - mine ?resource - resource ?node - node ?task - task)
        :precondition (and 
            ;;actor and mine are on same node
            (actorlocation ?actor ?node)
            (minelocation ?mine ?node)
            
            ;;(>= (neededresource ?task ?resource) 1)
        )
        :effect(and 
            ;;resource is created and placed
            (increase (node-resources ?node ?resource) 1)
        )
    )
    
    ;;pick up resource
    ;;Inputs actor, mine, resource, node
    (:action pickup
        :parameters (?actor - actor ?resource - resource ?node - node)
        :precondition (and 
            (actorlocation ?actor ?node)
            (= (holding-resource ?actor) 0)
            (>= (node-resources ?node ?resource) 1)
            ;;actor an resource in same location
        )
        :effect(and 
            (decrease (node-resources ?node ?resource) 1)
            (increase (holding-resource ?actor) 1)
        )
    )


    ;drop resource
    (:action drop
        :parameters (?actor - actor ?resource - resource ?node - node)
        :precondition (and 
            ;;actor is active and carrying a resource
            (actorstate ?actor)
            (actorlocation ?actor ?node)
            (resourceheld ?resource ?actor)
        )
        :effect(and 
            ;;actor no longer has resource
            (not(hasresource ?actor))
            (nothasresource ?actor)
            ;;;;resource location is created
            (increase (node-resources ?node ?resource) 1)
        )
    )


    ;;start construction 
    
;    (:action startconstruction
 ;       :parameters (?actor - actor ?node - node ?task - task)
  ;      :precondition (and
   ;         (actorstate ?actor)
    ;        (taskinactive ?task)
     ;       (nositeat ?node)
      ;      ;;both the actor and task are in the same location
       ;     (targetsite ?task ?node) 
 ;           (actorlocation ?actor ?node)
  ;      )
   ;     :effect(and
    ;        (taskactive ?task)
     ;       (not(taskinactive ?task)) 
      ;      (not(nositeat ?node))
       ;     (increase (todo-tasks ?actor) 1)
       ; )
   ; )

    (:action depositresource
        :parameters (?actor - actor ?task - task ?resource - resource ?node - node)
        :precondition (and 
            (actorstate ?actor)
            (targetsite ?task ?node)
            (=(holding-resource ?actor) 1) 
            (actorlocation ?actor ?node)

            ;(>= (neededresource ?task ?resource) 1)
        )
        :effect (and
            ;change the num-fluent
            (decrease (holding-resource ?actor) 1)
            ;(increase (node-resources ?node ?resource) 1)
            ;(decrease (neededresource ?task ?resource) 1)
            (decrease (number-resources-needed ?task) 1)
        )
    )
    

    ;;complete tasks 
    ;;if an agent is on a node and can complete task
    (:action finishconstruction
        :parameters (?actor - actor ?task - task ?node - node)
        :precondition (and 
            (actorstate ?actor)
            ;(taskactive ?task)
            ;(siteat ?node)
            ;actor and site location are here
            (actorlocation ?actor ?node)
            (targetsite ?task ?node)
            
            (= (number-resources-needed ?task) 0)
        )
        :effect (and 
            (taskcompleted ?task)
            (not(taskactive ?task))
            (taskinactive ?task)
            (decrease (todo-tasks ?actor) 1)
        )
    )
    

    
)