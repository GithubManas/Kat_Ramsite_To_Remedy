With Src_Kat_Terminal as (

    select * from {{ source('kat', 'Terminal') }}
),

stg_kat_terminal as (

    select
      [Terminal Id]
      ,[Navn]
      ,[Stednavn]
      ,[Teknisk]
      ,[Gade]
      ,[Nr]
      ,[Bogst]
      ,[Etage]
      ,[Lejl]
      ,[PostNr]
      ,[By]
      ,[Geocode]
      ,[Dok Central]
      ,[Share Connection 1]
      ,[Share Connection 2]
      ,[Damage Mark]
      ,getdate() as LoadDateTime
    from Src_Kat_Terminal
)

select * from stg_kat_terminal
