
(define (problem example-problem)
  (:domain htg-child-snack)
  (:objects
    child0 child1 child2 - child
    bread0 bread1 bread2 - bread-portion
    content-0 - content-description
    content-0-0 content-0-1 content-0-2 content-0-3 content-0-4 content-0-5 content-0-6 content-0-7 content-0-8 content-0-9 content-0-10 content-0-11 content-0-12 content-0-13 content-0-14 content-0-15 content-0-16 content-0-17 - content-portion
    tray0 tray1 tray2 - tray
    table0 table1 table2 table3 table4 - place
    sandw0 sandw1 sandw2 - sandwich
  )
  (:init
     ;; everythin starts in the kitchen
     (at tray0 kitchen)
     (at tray1 kitchen)
     (at tray2 kitchen)
			    (at_kitchen_bread bread0)
			    (at_kitchen_bread bread1)
			    (at_kitchen_bread bread2)
			    (at_kitchen_content content-0-0)
			    (at_kitchen_content content-0-1)
			    (at_kitchen_content content-0-2)
			    (at_kitchen_content content-0-3)
			    (at_kitchen_content content-0-4)
			    (at_kitchen_content content-0-5)
			    (at_kitchen_content content-0-6)
			    (at_kitchen_content content-0-7)
			    (at_kitchen_content content-0-8)
			    (at_kitchen_content content-0-9)
			    (at_kitchen_content content-0-10)
			    (at_kitchen_content content-0-11)
			    (at_kitchen_content content-0-12)
			    (at_kitchen_content content-0-13)
			    (at_kitchen_content content-0-14)
			    (at_kitchen_content content-0-15)
			    (at_kitchen_content content-0-16)
			    (at_kitchen_content content-0-17) 

     ;; content descriptions
                (descr content-0-0 content-0)
                (descr content-0-1 content-0)
                (descr content-0-2 content-0)
                (descr content-0-3 content-0)
                (descr content-0-4 content-0)
                (descr content-0-5 content-0)
                (descr content-0-6 content-0)
                (descr content-0-7 content-0)
                (descr content-0-8 content-0)
                (descr content-0-9 content-0)
                (descr content-0-10 content-0)
                (descr content-0-11 content-0)
                (descr content-0-12 content-0)
                (descr content-0-13 content-0)
                (descr content-0-14 content-0)
                (descr content-0-15 content-0)
                (descr content-0-16 content-0)
                (descr content-0-17 content-0)
     
     ;; which sandwichs the kids accept
     (likes child1 content-0)
     (likes child2 content-0)
     (likes child0 content-0)

     ;; where children are
     (waiting child0 table0)
     (waiting child1 table1)
     (waiting child2 table2)

     ;;sandwich dummies
     (notexist sandw0)
     (notexist sandw1)
     (notexist sandw2)
  )
  (:goal
    (and
     (served child0)
     (served child1)
     (served child2)
    )
  )
)

