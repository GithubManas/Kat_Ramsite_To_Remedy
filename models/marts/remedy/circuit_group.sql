
With Stg_Kat_MobileCircuit as (

    select * from {{ ref('stg_kat_mobilecircuit') }}
),
circuit_group as (
select distinct
             [Group Circuit T1]+'-'+[Group Circuit T2] as [Circuit Group ID],
             [Group Circuit T1],
             [Group Circuit T2],
             [Group Circuit Type] as [Group Type]
from 
             Stg_Kat_MobileCircuit
where 
             [Group Circuit] is not null
)

select * from circuit_group