With Src_Ramsite_Cell as (

    select * from {{ source('ramsite', 'cell') }}
),

stg_ramsite_cell as (

    select
      [Cell Id]
      ,[Site Id]
      ,[Name]
      ,[Status]
      ,[System Type]
      ,[Traffic Area]
      ,[Position]
      ,[Azimuth]
      ,[Sector]
      ,[Center Name]
      ,[Radius]
      ,[NodeName]
      ,[eNodeB ID]
      ,[gNodeB ID]
      ,[BSC_RNC]
      ,getdate() as LoadDateTime
    from Src_Ramsite_Cell

)

select * from stg_ramsite_cell
