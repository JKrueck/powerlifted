
(define (problem visitall-5-dim-p-2)
(:domain visitall-5-dim)
(:objects 
	p0 p1 p2 p3 p4 p5 p6 p7 p8 p9 - pos
)
(:init
	(at-robot p0 p0 p0 p0 p0)
	(visited p0 p0 p0 p0 p0)
	(neighbor p0 p1)
(neighbor p1 p0)
(neighbor p1 p2)
(neighbor p2 p1)
(neighbor p2 p3)
(neighbor p3 p2)
(neighbor p3 p4)
(neighbor p4 p3)
(neighbor p4 p5)
(neighbor p5 p4)
(neighbor p5 p6)
(neighbor p6 p5)
(neighbor p6 p7)
(neighbor p7 p6)
(neighbor p7 p8)
(neighbor p8 p7)
(neighbor p8 p9)
(neighbor p9 p8)
)
(:goal
(and 
	(visited p9 p9 p9 p8 p5)
(visited p8 p9 p9 p7 p7)
(visited p9 p6 p9 p9 p7)
)
)
)

