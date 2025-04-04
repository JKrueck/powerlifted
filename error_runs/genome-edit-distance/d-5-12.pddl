;; original sequence 1: (1 2 3 4 9 10 11 12 13 14 15 -76 -75 -74 -73 -72 -71 -70 -69 -68 -67 -66 -65 -64 -63 -62 -61 -60 -59 -58 -57 -56 -27 -26 -44 -43 -42 -41 45 46 47 48 -36 -35 -25 -24 -23 -22 -21 -20 -19 -18 -17 -16 -90 -89 -88 -87 -86 -85 -84 77 78 79 80 81 82 83 91 92 93 94 95 96 5 6 7 8 -55 -54 -53 -105 -104 -103 -102 -101 -100 -99 -98 28 29 30 31 32 33 34 -40 -39 -38 -37 49 50 51 52 -97)
;; original sequence 2: (1 8 2 3 4 5 29 30 31 32 33 34 35 36 -56 -55 -54 -53 -52 -51 -50 -28 -27 -26 9 -49 -48 -47 -46 -45 41 42 43 44 37 38 39 40 16 17 18 19 20 21 22 23 24 25 10 11 12 13 14 15 57 58 59 6 7 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 -105 -104 -103 -102 -101 -100 -99 -98 -97)
;; simplified sequence 1: (1 117 9 114 106 119 -56 121 109 122 107 111 110 113 5 120 8 116 108 28 112 115 49 118 -97)
;; simplified sequence 2: (1 8 117 5 112 -122 -56 116 -118 -28 121 9 -49 -109 -115 -107 114 -119 120 -106 110 -111 113 108 -97)
;; common subsequences: (((-76 -75 -74 -73 -72 -71 -70 -69 -68 -67 -66 -65 -64 -63 -62 -61 -60) . 106) ((-25 -24 -23 -22 -21 -20 -19 -18 -17 -16) . 107) ((-105 -104 -103 -102 -101 -100 -99 -98) . 108) ((-44 -43 -42 -41 45 46 47 48) . 109) ((77 78 79 80 81 82 83) . 110) ((-90 -89 -88 -87 -86 -85 -84) . 111) ((29 30 31 32 33 34) . 112) ((91 92 93 94 95 96) . 113) ((10 11 12 13 14 15) . 114) ((-40 -39 -38 -37) . 115) ((-55 -54 -53) . 116) ((2 3 4) . 117) ((50 51 52) . 118) ((-59 -58 -57) . 119) ((6 7) . 120) ((-27 -26) . 121) ((-36 -35) . 122))
;; #safe insertions/deletions: 0
;; sequence 1 (names): ((normal g1) (normal sub12) (normal g9) (normal sub9) (normal sub1) (normal sub14) (inverted g56) (normal sub16) (normal sub4) (normal sub17) (normal sub2) (normal sub6) (normal sub5) (normal sub8) (normal g5) (normal sub15) (normal g8) (normal sub11) (normal sub3) (normal g28) (normal sub7) (normal sub10) (normal g49) (normal sub13) (inverted g97))
;; sequence 2 (names): ((normal g1) (normal g8) (normal sub12) (normal g5) (normal sub7) (inverted sub17) (inverted g56) (normal sub11) (inverted sub13) (inverted g28) (normal sub16) (normal g9) (inverted g49) (inverted sub4) (inverted sub10) (inverted sub2) (normal sub9) (inverted sub14) (normal sub15) (inverted sub1) (normal sub5) (inverted sub6) (normal sub8) (normal sub3) (inverted g97))

(define (problem legousia-to-platycodon) (:domain genome-edit-distance)
        (:objects sub17 sub16 sub15 sub14 sub13 sub12 sub11 sub10 sub9
            sub8 sub7 sub6 sub5 sub4 sub3 sub2 sub1 g97 g56 g49 g28 g9
            g8 g5 g1)
        (:init (normal g1) (normal sub12) (normal g9) (normal sub9)
               (normal sub1) (normal sub14) (inverted g56)
               (normal sub16) (normal sub4) (normal sub17)
               (normal sub2) (normal sub6) (normal sub5) (normal sub8)
               (normal g5) (normal sub15) (normal g8) (normal sub11)
               (normal sub3) (normal g28) (normal sub7) (normal sub10)
               (normal g49) (normal sub13) (inverted g97) (present g1)
               (present sub12) (present g9) (present sub9)
               (present sub1) (present sub14) (present g56)
               (present sub16) (present sub4) (present sub17)
               (present sub2) (present sub6) (present sub5)
               (present sub8) (present g5) (present sub15) (present g8)
               (present sub11) (present sub3) (present g28)
               (present sub7) (present sub10) (present g49)
               (present sub13) (present g97) (cw g97 g1) (cw sub13 g97)
               (cw g49 sub13) (cw sub10 g49) (cw sub7 sub10)
               (cw g28 sub7) (cw sub3 g28) (cw sub11 sub3)
               (cw g8 sub11) (cw sub15 g8) (cw g5 sub15) (cw sub8 g5)
               (cw sub5 sub8) (cw sub6 sub5) (cw sub2 sub6)
               (cw sub17 sub2) (cw sub4 sub17) (cw sub16 sub4)
               (cw g56 sub16) (cw sub14 g56) (cw sub1 sub14)
               (cw sub9 sub1) (cw g9 sub9) (cw sub12 g9) (cw g1 sub12)
               (idle) (= (total-cost) 0))
        (:goal (and (normal g1) (normal g8) (normal sub12) (normal g5)
                    (normal sub7) (inverted sub17) (inverted g56)
                    (normal sub11) (inverted sub13) (inverted g28)
                    (normal sub16) (normal g9) (inverted g49)
                    (inverted sub4) (inverted sub10) (inverted sub2)
                    (normal sub9) (inverted sub14) (normal sub15)
                    (inverted sub1) (normal sub5) (inverted sub6)
                    (normal sub8) (normal sub3) (inverted g97)
                    (cw g97 g1) (cw sub3 g97) (cw sub8 sub3)
                    (cw sub6 sub8) (cw sub5 sub6) (cw sub1 sub5)
                    (cw sub15 sub1) (cw sub14 sub15) (cw sub9 sub14)
                    (cw sub2 sub9) (cw sub10 sub2) (cw sub4 sub10)
                    (cw g49 sub4) (cw g9 g49) (cw sub16 g9)
                    (cw g28 sub16) (cw sub13 g28) (cw sub11 sub13)
                    (cw g56 sub11) (cw sub17 g56) (cw sub7 sub17)
                    (cw g5 sub7) (cw sub12 g5) (cw g8 sub12)
                    (cw g1 g8)))
        (:metric minimize (total-cost)))