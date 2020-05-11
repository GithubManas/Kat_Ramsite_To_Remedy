With Src_Ramsite_Site as (

    select * from {{ source('ramsite', 'site') }}
),

stg_ramsite_site as (

    select
      [Site Id]
      ,[Site Name]
      ,[English Name]
      ,[Cluster]
      ,[Priority]
      ,[RNC ID]
      ,[BSC ID]
      ,[EPC ID]
      ,[Site Status]
      ,[Address 1]
      ,[House No]
      ,[PostCode]
      ,[City]
      ,[Municipality]
      ,[County]
      ,[Country]
      ,[Easting UTM32-ED50]
      ,[Northing UTM32-ED50]
      ,[Longitude-WGS84]
      ,[Latitude-WGS84]
      ,[Site Type]
      ,[Structure Type]
      ,[Transmission Name]
      ,[CircuitIds]
      ,getdate() as LoadDateTime
    from Src_Ramsite_Site
    Where
        [Site Status] in ('Ready','On Air')

)

select * from stg_ramsite_site
