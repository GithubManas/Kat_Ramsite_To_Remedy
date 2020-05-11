With stg_kat_terminal as (

    select * from {{ ref('stg_kat_terminal') }}
),

tx_terminal as (

    select 
             T.[Terminal Id] as TxID, 
             T.Teknisk as [NE Type] ,
             T.Navn as [NE Name] , 
             T.Gade + ' '+ T.Nr +' '+ isnull( T.Bogst,'') +' '+ isnull(T.Etage ,'') +' ' + isnull(T.Lejl,'') as [Address]  ,
             T.PostNr as PostalCode ,
             T.[By] as City ,
             T.Geocode  
from  stg_kat_terminal T  
)
select * from tx_terminal
