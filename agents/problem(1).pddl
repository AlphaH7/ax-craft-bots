(define(problem craft-bots-problem)
(:domain craft-bots)
(:objects
	a25 a27 a26 - actor
	l0 l1 l3 l5 l7 l9 l11 l13 l15 l17 - location
	m32 m31 m28 m29 m30 - mine
	red blue orange black green - resource
	t19 t20 t21 t22 t23 t24 - task
)
(:init
	(alocation a25 l0)
	(not (alocation a25 l1))
	(not (alocation a25 l3))
	(not (alocation a25 l5))
	(not (alocation a25 l7))
	(not (alocation a25 l9))
	(not (alocation a25 l11))
	(not (alocation a25 l13))
	(not (alocation a25 l15))
	(not (alocation a25 l17))

	(alocation a27 l0)
	(not (alocation a27 l1))
	(not (alocation a27 l3))
	(not (alocation a27 l5))
	(not (alocation a27 l7))
	(not (alocation a27 l9))
	(not (alocation a27 l11))
	(not (alocation a27 l13))
	(not (alocation a27 l15))
	(not (alocation a27 l17))

	(alocation a26 l1)
	(not (alocation a26 l0))
	(not (alocation a26 l3))
	(not (alocation a26 l5))
	(not (alocation a26 l7))
	(not (alocation a26 l9))
	(not (alocation a26 l11))
	(not (alocation a26 l13))
	(not (alocation a26 l15))
	(not (alocation a26 l17))

	(mcolour m32 green)
	(mlocation m32 l0)
	(mcolour m31 black)
	(mlocation m31 l3)
	(mcolour m28 red)
	(mlocation m28 l5)
	(mcolour m29 blue)
	(mlocation m29 l15)
	(mcolour m30 orange)
	(mlocation m30 l17)

	(not (carry a25 red))
	(not (carry a25 blue))
	(not (carry a25 green))
	(not (carry a25 orange))
	(not (carry a25 black))

	(not (carry a26 red))
	(not (carry a26 blue))
	(not (carry a26 green))
	(not (carry a26 orange))
	(not (carry a26 black))

	(not (carry a27 red))
	(not (carry a27 blue))
	(not (carry a27 green))
	(not (carry a27 orange))
	(not (carry a27 black))

	(not-carry a25 red)
	(not-carry a25 blue)
	(not-carry a25 green)
	(not-carry a25 orange)
	(not-carry a25 black)

	(not-carry a26 red)
	(not-carry a26 blue)
	(not-carry a26 green)
	(not-carry a26 orange)
	(not-carry a26 black)

	(not-carry a27 red)
	(not-carry a27 blue)
	(not-carry a27 green)
	(not-carry a27 orange)
	(not-carry a27 black)

	(not(deposited a25 red l3))
	(not(deposited a25 blue l3))
	(not(deposited a25 green l3))
	(not(deposited a25 orange l3))
	(not(deposited a25 black l3))

	(not(deposited a26 red l3))
	(not(deposited a26 blue l3))
	(not(deposited a26 green l3))
	(not(deposited a26 orange l3))
	(not(deposited a26 black l3))

	(not(deposited a26 red l3))
	(not(deposited a26 blue l3))
	(not(deposited a26 green l3))
	(not(deposited a26 orange l3))
	(not(deposited a26 black l3))

	(not-deposited a25 red l3)
	(not-deposited a25 blue l3)
	(not-deposited a25 green l3)
	(not-deposited a25 orange l3)
	(not-deposited a25 black l3)

	(not-deposited a26 red l3)
	(not-deposited a26 blue l3)
	(not-deposited a26 green l3)
	(not-deposited a26 orange l3)
	(not-deposited a26 black l3)

	(not-deposited a26 red l3)
	(not-deposited a26 blue l3)
	(not-deposited a26 green l3)
	(not-deposited a26 orange l3)
	(not-deposited a26 black l3)

	(connects l1 l0)
	(connects l0 l1)
	(connects l3 l1)
	(connects l1 l3)
	(connects l5 l3)
	(connects l3 l5)
	(connects l7 l5)
	(connects l5 l7)
	(connects l9 l7)
	(connects l7 l9)
	(connects l11 l9)
	(connects l9 l11)
	(connects l13 l11)
	(connects l11 l13)
	(connects l15 l13)
	(connects l13 l15)
	(connects l17 l15)
	(connects l15 l17)

	(not (occupied-site l3))
	(not (occupied-site l17))
	(not (occupied-site l15))
	(not (occupied-site l7))

	(not-occupied-site l3)
	(not-occupied-site l17)
	(not-occupied-site l15)
	(not-occupied-site l7)

	; Task number: 19 at node 3
	(= (needed_resources black l3 t19) 2)


)(:goal(and
	;(carry a26 black)
	(deposited a26 black l3)
	;(= (needed_resources black l3 t19) 1)
))
)