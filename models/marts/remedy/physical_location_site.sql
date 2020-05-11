With Stg_Ramsite_Site as (

    select * from {{ ref('stg_ramsite_site') }}
),
 Stg_Kat_Terminal as (

    select * from {{ ref('stg_kat_terminal') }}
),
Stg_Kat_MobileCircuit as (

    select * from {{ ref('stg_kat_mobilecircuit') }}
),
Site_CTE  
	AS  
	(
	select [Site Id] ,   
							case 
										when substring(  value  , len(value)  , len(value) ) in ('U','L') 
										then  substring(  value  ,1, len(value) -1 )
							else value
							end as CircuitId
	from stg_ramsite_site S   
	CROSS APPLY STRING_SPLIT(S.CircuitIds, ',') 
	) ,
physical_location_site as (

    
	select DISTINCT
	substring ( navn ,1, charindex(' ', navn )) as [Site ID] ,
	mc.[Mobile Terminal], 
	S.[Site Status] as [Site Status],
	S.[Site Name],
	S.[English Name],
	S.Cluster,
	S.Priority as [Site Priority],  
	S.[RNC ID] ,
	S.[BSC ID] ,
	S.[EPC ID] ,
	S.[Address 1] + ' '+ S.[House No]  as [Address] ,
	s.PostCode as [PostalCode],
	s.City,
	S.Municipality as Municipal,
	S.County as Region,
	S.[Easting UTM32-ED50] ,
	S.[Northing UTM32-ED50] ,
	S.[Longitude-WGS84] , 
	S.[Latitude-WGS84] 
	from 
				stg_ramsite_site S 
					join 
				stg_kat_terminal T 
							on replicate( '0' , 4-len([Site Id])  ) + [Site Id] = substring ( navn ,1, charindex(' ', navn )) 
							and S.City = T.[By]
							and S.PostCode = T.PostNr
		join
				stg_kat_mobilecircuit mc
							on  T.[Terminal Id] = mc.[Mobile Terminal]
					join
				Site_CTE SC
							on S.[Site Id] = SC.[Site Id]
							and SC.CircuitId = mc.circuitid
	where 
				-- S.[Site Status] IN ('On Air','Ready') and
				 upper(mc.[Mobile Terminal]) like '%TDM%' 

)

select * from physical_location_site
