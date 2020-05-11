With Stg_Ramsite_Cell as (

    select * from {{ ref('stg_ramsite_cell') }}
),

mobile_cell as (

    select 
             [Cell Id],
             '' test1,
             [Site Id] ,
             Name  as [Cell Name] ,
             Status as [Cell Status],
             case 
                          when [System Type] like '%GSM%' then '2G'
                          when [System Type] like '%UMTS%' then '3G'
                          when [System Type] like '%LTE%' then '4G'
                          else '5G'
             end [Cell Type],
             [System Type] ,
             [Traffic Area] ,
             Position as Cell_Position,
             Azimuth ,
             Sector ,
             Radius as [Cell Radius],
             NodeName as [NodeName],
             [eNodeB ID] as [eNodeB ID],
             [gNodeB ID] as [gNodeB ID] ,
             BSC_RNC as BSC_RNC 
    from    
                stg_ramsite_cell

)

select * from mobile_cell
