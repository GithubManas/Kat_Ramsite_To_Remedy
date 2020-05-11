With Src_Kat_MobileCircuit as (

    select * from {{ source('kat', 'MobileCircuit') }}
),

stg_kat_mobilecircuit as (

    select
      [CircuitID]
      ,[Mobile Terminal]
      ,[Root Terminal]
      ,[Circuit Status]
      ,[Damage Mark]
      ,[Cable Share Plant]
      ,[Last mile Terminal]
      ,[Group Circuit]
      ,[Group Circuit T1]
      ,[Group Circuit T2]
      ,[Group Circuit Position]
      ,[Group Circuit Type]
      ,getdate() as LoadDateTime
    from 
      Src_Kat_MobileCircuit
    where 
      [Circuit Status] in ('Active','Damaged')

)

select * from stg_kat_mobilecircuit
