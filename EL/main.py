import boto3
from botocore import UNSIGNED
from botocore.client import Config
import pandas as pd
import io

s3 = boto3.client('s3', config=Config(signature_version=UNSIGNED))
bucket_name = "d2b-internal-assessment-bucket"
response = s3.list_objects(Bucket=bucket_name, Prefix="orders_data")
# for example to download the orders.csv
s3.download_file(bucket_name, "orders_data/orders.csv", "orders.csv")
s3.download_file(bucket_name, "orders_data/reviews.csv", "reviews.csv")
s3.download_file(bucket_name, "orders_data/shipment_deliveries.csv", "shipment_deliveries.csv")
s3.download_file(bucket_name, "orders_data/analytics_export/murtodun9658/agg_public_holiday.csv", "agg_public_holiday.csv")
s3.download_file(bucket_name, "orders_data/analytics_export/murtodun9658/agg_shipments.csv", "agg_shipments.csv")
s3.download_file(bucket_name, "orders_data/analytics_export/murtodun9658/best_performing_product.csv", "best_performing_product.csv")
s3.download_file(bucket_name, "orders_data/analytics_export/murtodun9658/late_shipments.csv", "late_shipments.csv")
s3.download_file(bucket_name, "orders_data/analytics_export/murtodun9658/undelivered_shipments.csv", "undelivered_shipments.csv")


s3.download_file(bucket_name, "orders_data/dim_customers.csv", "dim_customers.csv")
