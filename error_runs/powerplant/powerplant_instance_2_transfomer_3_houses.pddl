(define (problem powerplant_instance_2_transfomer_3_houses) (:domain Powerplant)
    (:objects
    p1 - powerplant
    t1 - transformer
    t2 - transformer
    h1_1 - house
    lp1_1 - low_voltage_line
    h1_2 - house
    lp1_2 - low_voltage_line
    h1_3 - house
    lp1_3 - low_voltage_line
    HP1 - high_voltage_line
    h2_1 - house
    lp2_1 - low_voltage_line
    h2_2 - house
    lp2_2 - low_voltage_line
    h2_3 - house
    lp2_3 - low_voltage_line
    HP2 - high_voltage_line
   lpTransformer_1 - low_voltage_line
   lpTransformer_2 - low_voltage_line
    )
    (:init
    (0Volt p1)
    (connected p1 t1 HP1)
    (transmissionSafe HP1)
    (connected p1 t2 HP2)
    (transmissionSafe HP2)
    (connected h1_1 h1_2 lp1_1)
    (transmissionSafe lp1_1)
    (needsElectricity h1_1)
    (connected h1_2 h1_3 lp1_2)
    (transmissionSafe lp1_2)
    (needsElectricity h1_2)
    (needsElectricity h1_3)
    (connected t1 h1_1 lpTransformer_1)
    (transmissionSafe lpTransformer_1)
    (needsElectricity t1)
    (connected h2_1 h2_2 lp2_1)
    (transmissionSafe lp2_1)
    (needsElectricity h2_1)
    (connected h2_2 h2_3 lp2_2)
    (transmissionSafe lp2_2)
    (needsElectricity h2_2)
    (needsElectricity h2_3)
    (connected t2 h2_1 lpTransformer_2)
    (transmissionSafe lpTransformer_2)
    (needsElectricity t2)
    (systemsSafe)
    )
    (:goal
        (and
            (230Volt h1_1)
            (230Volt h1_2)
            (230Volt h1_3)
            (230Volt h2_1)
            (230Volt h2_2)
            (230Volt h2_3)
        )
    )
)
