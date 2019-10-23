;; original sequence 1: (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105)
;; original sequence 2: (1 2 3 4 5 6 7 8 9 10 49 50 51 52 53 28 29 30 31 32 33 34 35 -40 -39 -38 -37 -60 -59 -58 -57 -56 11 12 13 14 15 -76 -75 -74 -73 -72 -71 -70 -69 -68 -67 -66 -65 -64 -63 -62 -61 -27 -26 -44 -43 -42 -41 45 46 47 48 -36 54 -25 -24 -23 -22 -21 -20 -19 -18 -17 -16 -90 -89 -88 -87 -86 -85 77 78 79 80 81 82 83 84 91 92 93 94 95 96 -55 -105 -104 -103 -102 -101 -100 -99 -98 -97)
;; simplified sequence 1: (107 115 108 120 111 36 119 118 117 114 54 55 116 106 110 113 112 109)
;; simplified sequence 2: (107 114 111 -119 -116 115 -106 -120 -118 117 -36 54 -108 -113 110 112 -55 -109)
;; common subsequences: (((61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76) . 106) ((1 2 3 4 5 6 7 8 9 10) . 107) ((16 17 18 19 20 21 22 23 24 25) . 108) ((97 98 99 100 101 102 103 104 105) . 109) ((77 78 79 80 81 82 83 84) . 110) ((28 29 30 31 32 33 34 35) . 111) ((91 92 93 94 95 96) . 112) ((85 86 87 88 89 90) . 113) ((49 50 51 52 53) . 114) ((11 12 13 14 15) . 115) ((56 57 58 59 60) . 116) ((45 46 47 48) . 117) ((41 42 43 44) . 118) ((37 38 39 40) . 119) ((26 27) . 120))
;; #safe insertions/deletions: 0
;; sequence 1 (names): ((NORMAL SUB2) (NORMAL SUB10) (NORMAL SUB3) (NORMAL SUB15) (NORMAL SUB6) (NORMAL G36) (NORMAL SUB14) (NORMAL SUB13) (NORMAL SUB12) (NORMAL SUB9) (NORMAL G54) (NORMAL G55) (NORMAL SUB11) (NORMAL SUB1) (NORMAL SUB5) (NORMAL SUB8) (NORMAL SUB7) (NORMAL SUB4))
;; sequence 2 (names): ((NORMAL SUB2) (NORMAL SUB9) (NORMAL SUB6) (INVERTED SUB14) (INVERTED SUB11) (NORMAL SUB10) (INVERTED SUB1) (INVERTED SUB15) (INVERTED SUB13) (NORMAL SUB12) (INVERTED G36) (NORMAL G54) (INVERTED SUB3) (INVERTED SUB8) (NORMAL SUB5) (NORMAL SUB7) (INVERTED G55) (INVERTED SUB4))

(DEFINE (PROBLEM TOBACCO-TO-MERCIERA) (:DOMAIN GENOME-EDIT-DISTANCE)
        (:OBJECTS SUB15 SUB14 SUB13 SUB12 SUB11 SUB10 SUB9 SUB8 SUB7
            SUB6 SUB5 SUB4 SUB3 SUB2 SUB1 G55 G54 G36)
        (:INIT (NORMAL SUB2) (NORMAL SUB10) (NORMAL SUB3)
               (NORMAL SUB15) (NORMAL SUB6) (NORMAL G36) (NORMAL SUB14)
               (NORMAL SUB13) (NORMAL SUB12) (NORMAL SUB9) (NORMAL G54)
               (NORMAL G55) (NORMAL SUB11) (NORMAL SUB1) (NORMAL SUB5)
               (NORMAL SUB8) (NORMAL SUB7) (NORMAL SUB4) (PRESENT SUB2)
               (PRESENT SUB10) (PRESENT SUB3) (PRESENT SUB15)
               (PRESENT SUB6) (PRESENT G36) (PRESENT SUB14)
               (PRESENT SUB13) (PRESENT SUB12) (PRESENT SUB9)
               (PRESENT G54) (PRESENT G55) (PRESENT SUB11)
               (PRESENT SUB1) (PRESENT SUB5) (PRESENT SUB8)
               (PRESENT SUB7) (PRESENT SUB4) (CW SUB4 SUB2)
               (CW SUB7 SUB4) (CW SUB8 SUB7) (CW SUB5 SUB8)
               (CW SUB1 SUB5) (CW SUB11 SUB1) (CW G55 SUB11)
               (CW G54 G55) (CW SUB9 G54) (CW SUB12 SUB9)
               (CW SUB13 SUB12) (CW SUB14 SUB13) (CW G36 SUB14)
               (CW SUB6 G36) (CW SUB15 SUB6) (CW SUB3 SUB15)
               (CW SUB10 SUB3) (CW SUB2 SUB10) (IDLE)
               (= (TOTAL-COST) 0))
        (:GOAL (AND (NORMAL SUB2) (NORMAL SUB9) (NORMAL SUB6)
                    (INVERTED SUB14) (INVERTED SUB11) (NORMAL SUB10)
                    (INVERTED SUB1) (INVERTED SUB15) (INVERTED SUB13)
                    (NORMAL SUB12) (INVERTED G36) (NORMAL G54)
                    (INVERTED SUB3) (INVERTED SUB8) (NORMAL SUB5)
                    (NORMAL SUB7) (INVERTED G55) (INVERTED SUB4)
                    (CW SUB4 SUB2) (CW G55 SUB4) (CW SUB7 G55)
                    (CW SUB5 SUB7) (CW SUB8 SUB5) (CW SUB3 SUB8)
                    (CW G54 SUB3) (CW G36 G54) (CW SUB12 G36)
                    (CW SUB13 SUB12) (CW SUB15 SUB13) (CW SUB1 SUB15)
                    (CW SUB10 SUB1) (CW SUB11 SUB10) (CW SUB14 SUB11)
                    (CW SUB6 SUB14) (CW SUB9 SUB6) (CW SUB2 SUB9)))
        (:METRIC MINIMIZE (TOTAL-COST)))