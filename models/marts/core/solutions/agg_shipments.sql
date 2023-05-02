select 
       (SELECT '{{ run_started_at.strftime("%Y-%m-%d") }}') as ingestion_date,
       (SELECT COUNT(ORDER_ID) FROM {{ref('late_shipments_df')}} ) as tt_late_shipments, 
       (SELECT COUNT(ORDER_ID) FROM {{ref('undelivered_shipment_df')}} ) as tt_undelivered_shipments 