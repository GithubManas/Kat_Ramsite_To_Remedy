With stg_kat_sharedcableplant as (

    select * from {{ ref('stg_kat_sharedcableplant') }}
),

share_cable as (

    select 
             [Share Cable Nr] as CableID,
             substring ( substring ([Share Cable Id],1,len([Share Cable Id])-len([Share Cable Nr]) ) , charindex('-', substring ([Share Cable Id],1,len([Share Cable Id])-len([Share Cable Nr]) ) )+1,len(substring ([Share Cable Id],1,len([Share Cable Id])-len([Share Cable Nr]) ))  ) as [Terminal 1_RTN],
             substring ( substring ([Share Cable Id],1,len([Share Cable Id])-len([Share Cable Nr]) ) ,1, charindex('-', substring ([Share Cable Id],1,len([Share Cable Id])-len([Share Cable Nr]) ) )-1 ) as [Terminal 2_Lmile T.],
             [Last Mile Cable Junction] as [Lmile Cable Junction],
             [Last Mile Junction Terminal] as [Lmile Junction Terminal],
             [Cable Status]
    from stg_kat_sharedcableplant

)
select * from share_cable
