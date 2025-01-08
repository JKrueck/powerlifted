(define (problem powerplant_instance_1_transfomer_10_houses) (:domain Powerplant)
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
    (needsElectricity h1_10)
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
        )
    )
)
