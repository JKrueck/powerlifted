
(define (problem visitall-5-dim-p-1)
(:domain visitall-5-dim)
(:objects 
	p0 p1 p2 p3 p4 p5 p6 p7 - pos
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
)
(:goal
(and 
	(visited p1 p2 p1 p1 p0)
(visited p0 p2 p2 p1 p0)
(visited p1 p3 p1 p0 p0)
)
)
)

