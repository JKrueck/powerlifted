(define (problem powerplant_instance_1_transfomer_3_houses) (:domain Powerplant)
    (:objects
    p1 - powerplant
    t1 - transformer
    h1_1 - house
    lp1_1 - low_voltage_line
    h1_2 - house
    lp1_2 - low_voltage_line
    h1_3 - house
    lp1_3 - low_voltage_line
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
    (needsElectricity h1_3)
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
        )
    )
)
