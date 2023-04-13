select * from staging.external_staging.ORDERS_TABLE;

WITH orders_2 AS (
    select
        order_id,
        customer_id,
        order_date,
        product_id,
        unit_price,
        quantity,
        total_price

    FROM staging.external_staging.ORDERS_TABLE
),
shipment_deliveries_2 AS (
    select  	
        shipment_id,
        order_id,
        shipment_date,
        delivery_date

    FROM staging.external_staging.SHIPMENT_DELIVERIES_TABLE
),
merged_2 as(
    select * from shipment_deliveries_2
    left join orders_2 using (order_id)
),
final_2 as(
    SELECT * FROM merged_2 
    WHERE '2022-09-01' >= DATEADD(day, 15, ORDER_DATE)
    AND DELIVERY_DATE IS NULL
    AND SHIPMENT_DATE IS NULL
)
select * from final_2;