(define (problem powerplant_instance_1_transfomer_30_houses) (:domain Powerplant)
    (:objects
    p1 - powerplant
    t1 - transformer
    h1_1 - house
    lp1_1 - low_voltage_line
    h1_2 - house
    lp1_2 - low_voltage_line
    h1_3 - house
    lp1_3 - low_voltage_line
    h1_4 - house
    lp1_4 - low_voltage_line
    h1_5 - house
    lp1_5 - low_voltage_line
    h1_6 - house
    lp1_6 - low_voltage_line
    h1_7 - house
    lp1_7 - low_voltage_line
    h1_8 - house
    lp1_8 - low_voltage_line
    h1_9 - house
    lp1_9 - low_voltage_line
    h1_10 - house
    lp1_10 - low_voltage_line
    h1_11 - house
    lp1_11 - low_voltage_line
    h1_12 - house
    lp1_12 - low_voltage_line
    h1_13 - house
    lp1_13 - low_voltage_line
    h1_14 - house
    lp1_14 - low_voltage_line
    h1_15 - house
    lp1_15 - low_voltage_line
    h1_16 - house
    lp1_16 - low_voltage_line
    h1_17 - house
    lp1_17 - low_voltage_line
    h1_18 - house
    lp1_18 - low_voltage_line
    h1_19 - house
    lp1_19 - low_voltage_line
    h1_20 - house
    lp1_20 - low_voltage_line
    h1_21 - house
    lp1_21 - low_voltage_line
    h1_22 - house
    lp1_22 - low_voltage_line
    h1_23 - house
    lp1_23 - low_voltage_line
    h1_24 - house
    lp1_24 - low_voltage_line
    h1_25 - house
    lp1_25 - low_voltage_line
    h1_26 - house
    lp1_26 - low_voltage_line
    h1_27 - house
    lp1_27 - low_voltage_line
    h1_28 - house
    lp1_28 - low_voltage_line
    h1_29 - house
    lp1_29 - low_voltage_line
    h1_30 - house
    lp1_30 - low_voltage_line
    HP1 - high_voltage_line
   lpTransformer_1 - low_voltage_line
    )
    (:init
    (0Volt p1)
    (connected p1 t1 HP1)
    (transmissionSafe HP1)
    (connected h1_1 h1_2 lp1_1)
    (transmissionSafe lp1_1)
    (needsElectricity h1_1)
    (connected h1_2 h1_3 lp1_2)
    (transmissionSafe lp1_2)
    (needsElectricity h1_2)
    (connected h1_3 h1_4 lp1_3)
    (transmissionSafe lp1_3)
    (needsElectricity h1_3)
    (connected h1_4 h1_5 lp1_4)
    (transmissionSafe lp1_4)
    (needsElectricity h1_4)
    (connected h1_5 h1_6 lp1_5)
    (transmissionSafe lp1_5)
    (needsElectricity h1_5)
    (connected h1_6 h1_7 lp1_6)
    (transmissionSafe lp1_6)
    (needsElectricity h1_6)
    (connected h1_7 h1_8 lp1_7)
    (transmissionSafe lp1_7)
    (needsElectricity h1_7)
    (connected h1_8 h1_9 lp1_8)
    (transmissionSafe lp1_8)
    (needsElectricity h1_8)
    (connected h1_9 h1_10 lp1_9)
    (transmissionSafe lp1_9)
    (needsElectricity h1_9)
    (connected h1_10 h1_11 lp1_10)
    (transmissionSafe lp1_10)
    (needsElectricity h1_10)
    (connected h1_11 h1_12 lp1_11)
    (transmissionSafe lp1_11)
    (needsElectricity h1_11)
    (connected h1_12 h1_13 lp1_12)
    (transmissionSafe lp1_12)
    (needsElectricity h1_12)
    (connected h1_13 h1_14 lp1_13)
    (transmissionSafe lp1_13)
    (needsElectricity h1_13)
    (connected h1_14 h1_15 lp1_14)
    (transmissionSafe lp1_14)
    (needsElectricity h1_14)
    (connected h1_15 h1_16 lp1_15)
    (transmissionSafe lp1_15)
    (needsElectricity h1_15)
    (connected h1_16 h1_17 lp1_16)
    (transmissionSafe lp1_16)
    (needsElectricity h1_16)
    (connected h1_17 h1_18 lp1_17)
    (transmissionSafe lp1_17)
    (needsElectricity h1_17)
    (connected h1_18 h1_19 lp1_18)
    (transmissionSafe lp1_18)
    (needsElectricity h1_18)
    (connected h1_19 h1_20 lp1_19)
    (transmissionSafe lp1_19)
    (needsElectricity h1_19)
    (connected h1_20 h1_21 lp1_20)
    (transmissionSafe lp1_20)
    (needsElectricity h1_20)
    (connected h1_21 h1_22 lp1_21)
    (transmissionSafe lp1_21)
    (needsElectricity h1_21)
    (connected h1_22 h1_23 lp1_22)
    (transmissionSafe lp1_22)
    (needsElectricity h1_22)
    (connected h1_23 h1_24 lp1_23)
    (transmissionSafe lp1_23)
    (needsElectricity h1_23)
    (connected h1_24 h1_25 lp1_24)
    (transmissionSafe lp1_24)
    (needsElectricity h1_24)
    (connected h1_25 h1_26 lp1_25)
    (transmissionSafe lp1_25)
    (needsElectricity h1_25)
    (connected h1_26 h1_27 lp1_26)
    (transmissionSafe lp1_26)
    (needsElectricity h1_26)
    (connected h1_27 h1_28 lp1_27)
    (transmissionSafe lp1_27)
    (needsElectricity h1_27)
    (connected h1_28 h1_29 lp1_28)
    (transmissionSafe lp1_28)
    (needsElectricity h1_28)
    (connected h1_29 h1_30 lp1_29)
    (transmissionSafe lp1_29)
    (needsElectricity h1_29)
    (needsElectricity h1_30)
    (connected t1 h1_1 lpTransformer_1)
    (transmissionSafe lpTransformer_1)
    (needsElectricity t1)
    (systemsSafe)
    )
    (:goal
        (and
            (230Volt h1_1)
            (230Volt h1_2)
            (230Volt h1_3)
            (230Volt h1_4)
            (230Volt h1_5)
            (230Volt h1_6)
            (230Volt h1_7)
            (230Volt h1_8)
            (230Volt h1_9)
            (230Volt h1_10)
            (230Volt h1_11)
            (230Volt h1_12)
            (230Volt h1_13)
            (230Volt h1_14)
            (230Volt h1_15)
            (230Volt h1_16)
            (230Volt h1_17)
            (230Volt h1_18)
            (230Volt h1_19)
            (230Volt h1_20)
            (230Volt h1_21)
            (230Volt h1_22)
            (230Volt h1_23)
            (230Volt h1_24)
            (230Volt h1_25)
            (230Volt h1_26)
            (230Volt h1_27)
            (230Volt h1_28)
            (230Volt h1_29)
            (230Volt h1_30)
        )
    )
)
