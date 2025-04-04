
(define (problem example-problem)
  (:domain htg-child-snack)
  (:objects
    child0 child1 child2 child3 child4 child5 child6 - child
    bread0 bread1 bread2 bread3 bread4 bread5 bread6 - bread-portion
    content-0 content-1 content-2 - content-description
    content-0-0 content-0-1 - content-portion
    content-1-0 - content-portion
    content-2-0 content-2-1 content-2-2 content-2-3 - content-portion
    tray0 tray1 tray2 - tray
    table0 table1 table2 table3 table4 - place
    sandw0 sandw1 sandw2 sandw3 sandw4 sandw5 sandw6 - sandwich
  )
  (:init
     ;; everythin starts in the kitchen
     (at tray0 kitchen)
     (at tray1 kitchen)
     (at tray2 kitchen)
			    (at_kitchen_bread bread0)
			    (at_kitchen_bread bread1)
			    (at_kitchen_bread bread2)
			    (at_kitchen_bread bread3)
			    (at_kitchen_bread bread4)
			    (at_kitchen_bread bread5)
			    (at_kitchen_bread bread6)
			    (at_kitchen_content content-0-0)
			    (at_kitchen_content content-0-1)
			    (at_kitchen_content content-1-0)
			    (at_kitchen_content content-2-0)
			    (at_kitchen_content content-2-1)
			    (at_kitchen_content content-2-2)
			    (at_kitchen_content content-2-3) 

     ;; content descriptions
                (descr content-0-0 content-0)
                (descr content-0-1 content-0)
                (descr content-1-0 content-1)
                (descr content-2-0 content-2)
                (descr content-2-1 content-2)
                (descr content-2-2 content-2)
                (descr content-2-3 content-2)
     
     ;; which sandwichs the kids accept
     (likes child3 content-0)
     (likes child0 content-0)
     (likes child5 content-2)
     (likes child4 content-2)
     (likes child2 content-2)
     (likes child6 content-2)
     (likes child1 content-1)

     ;; where children are
     (waiting child0 table0)
     (waiting child1 table1)
     (waiting child2 table2)
     (waiting child3 table3)
     (waiting child4 table4)
     (waiting child5 table0)
     (waiting child6 table1)

     ;;sandwich dummies
     (notexist sandw0)
     (notexist sandw1)
     (notexist sandw2)
     (notexist sandw3)
     (notexist sandw4)
     (notexist sandw5)
     (notexist sandw6)
  )
  (:goal
    (and
     (served child0)
     (served child1)
     (served child2)
     (served child3)
     (served child4)
     (served child5)
     (served child6)
    )
  )
)

