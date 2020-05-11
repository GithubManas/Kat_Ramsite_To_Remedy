With Stg_Kat_MobileCircuit as (

    select * from {{ ref('stg_kat_mobilecircuit') }}
),

mobile_circuit as (

select 
              CircuitID ,
             [Mobile Terminal] as [Terminal 1_MobileTerminal] ,
             [Root Terminal] as [Terminal 2_RootTerminal], 
              [Circuit Status],
             [Group Circuit] as [Logical Group Circuit] ,
             [Group Circuit Position] as [Group Position]
from    
             Stg_Kat_MobileCircuit
)

select * from mobile_circuit