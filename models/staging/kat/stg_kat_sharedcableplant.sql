With Src_Kat_SharedCablePlant as (

    select * from {{ source('kat', 'SharedCablePlant') }}
),

stg_kat_sharedcableplant as (

    select
       [Share Cable Id]
      ,[Share Cable Nr]
      ,[Last Mile Cable Junction]
      ,[Last Mile Junction Terminal]
      ,[Mobile Terminal]
      ,[Root Terminal]
      ,[Cable Status]
      ,[Damage Mark]
      ,getdate() as LoadDateTime
    from 
        Src_Kat_SharedCablePlant
    where 
        [Cable Status] in ('Active','Damaged')
)

select * from stg_kat_sharedcableplant
