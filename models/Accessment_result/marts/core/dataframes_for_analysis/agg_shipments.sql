select 
       (select count(distinct order_id) from {{ref( 'late_shipments_df')}}) as tt_late_shipments,
       (select count(distinct order_id)  from {{ref('undelivered_shipments_df')}}) as tt_undelivered_shipments
from  dual

