With Stg_Ramsite_Site as (

    select * from {{ ref('stg_ramsite_site') }}
),
Stg_Ramsite_Cell as (

    select * from {{ ref('stg_ramsite_cell') }}
),
 piv_tab as
      (
                  select * from (
                  select distinct 
                    RamSite_Site.[Site Id] , 
                    RamSite_Site.[Site Type] ,
                  case 
                                when RamSite_Cell.[System Type] like '%GSM%' then '2G'
                                when RamSite_Cell.[System Type] like '%UMTS%' then '3G'
                                when RamSite_Cell.[System Type] like '%LTE%' then '4G'
                                else '5G'
                  end [Cell Type]
                  from 
                                stg_ramsite_site as RamSite_Site
                                join
                                stg_ramsite_cell as RamSite_Cell
                                on RamSite_Site.[Site Id] = RamSite_Cell.[Site Id]
                                where RamSite_Cell.Status = 'OnAir') AS src 
                                PIVOT(
                                            max([Cell Type])
                                            FOR [Cell Type] IN ([2G],[3G],[4G],[5G]) ) as int_piv_tab
        ),  
site_type as (

      select 
                  [Site Id],
                  [Site Type],
                  case when [2G] is not null then 'Yes' else 'No' end [2G] ,
                  case when [3G] is not null then 'Yes' else 'No' end [3G],
                  case when [4G] is not null then 'Yes' else 'No' end [4G],
                  case when [5G] is not null then 'Yes' else 'No' end [5G]
      from piv_tab
 
)

select * from site_type