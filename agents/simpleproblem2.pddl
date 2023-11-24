(define(problem craft-bots-problem)
(:domain craft-bots)
(:objects
 a30 - actor
 n0 n1 n2 n3 n4 n5 - node
 m36 m37 - mine
 t24 t25 - task
 red blue orange black green - resource
 )

(:init
 (nositeat n0)
 (nositeat n1)
 (nositeat n2)
 (nositeat n3)
 (nositeat n4)
 (nositeat n5)


 (actorstate a30)
 (actorlocation a30 n2)

 (=(holding-resource a30) 0)


 (mine m36)
 (minelocation m36 n0)
 (mineresource m36 red)

 (mine m37)
 (minelocation m37 n1)
 (mineresource m37 blue)


 (taskinactive t24)
 (targetsite t24 n2)
 ;(=(neededresource t24 red) 2)
 (=(number-resources-needed t24) 2)

 (taskactive t25)
 (targetsite t25 n3)
 (=(number-resources-needed t25) 3)
 

 ;;node resources counts
 ;node 0
 (=(node-resources n0 red) 0)
 (=(node-resources n0 blue) 0)
 (=(node-resources n0 orange) 0)
 (=(node-resources n0 black) 0)
 (=(node-resources n0 green) 0)

;;node 1
 (=(node-resources n1 red) 0)
 (=(node-resources n1 blue) 0)
 (=(node-resources n0 orange) 0)
 (=(node-resources n0 black) 0)
 (=(node-resources n0 green) 0)
;;node 2
 (=(node-resources n2 red) 0)
 (=(node-resources n2 blue) 0)
 (=(node-resources n0 orange) 0)
 (=(node-resources n0 black) 0)
 (=(node-resources n0 green) 0)

;;node 3
 (=(node-resources n3 red) 0)
 (=(node-resources n3 blue) 0)
 (=(node-resources n0 orange) 0)
 (=(node-resources n0 black) 0)
 (=(node-resources n0 green) 0)

;;node 4
 (=(node-resources n4 red) 0)
 (=(node-resources n4 blue) 0)
 (=(node-resources n0 orange) 0)
 (=(node-resources n0 black) 0)
 (=(node-resources n0 green) 0)
;;node 5
 (=(node-resources n5 red) 0)
 (=(node-resources n5 blue) 0)
 (=(node-resources n0 orange) 0)
 (=(node-resources n0 black) 0)
 (=(node-resources n0 green) 0)

 (connection n0 n1)
 (connection n1 n0)
 (connection n1 n2)
 (connection n2 n1)
 (connection n2 n3)
 (connection n3 n2)
 (connection n3 n4)
 (connection n4 n3)
 (connection n4 n5)
 (connection n5 n4)

 )
(:goal
 (and

  (taskcompleted t24)
  (taskcompleted t25)
  ;(= (node-resources n2 red) 2)

  ;; can't yet figure out finish construction 
    ;;the tricky part is that each task has multiple resource types of think of 
    ;; is finishing the tasks here the best way to do this? 
 )
)

)
