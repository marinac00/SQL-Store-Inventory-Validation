--FASE 1:  Data imported from product_inventory.csv Kaggel
-- public.produkt definition

-- Drop table

-- DROP TABLE public.produkt;

CREATE TABLE public.produkt (
	"SKU_ID" varchar(50) NULL,
	"SKU_Name" varchar(50) NULL,
	"Category" varchar(50) NULL,
	"ABC_Class" varchar(50) NULL,
	"Supplier_ID" varchar(50) NULL,
	"Supplier_Name" varchar(50) NULL,
	"Warehouse_ID" varchar(50) NULL,
	"Warehouse_Location" varchar(50) NULL,
	"Batch_ID" varchar(50) NULL,
	"Received_Date" varchar(50) NULL,
	"Last_Purchase_Date" varchar(50) NULL,
	"Expiry_Date" varchar(50) NULL,
	"Stock_Age_Days" int4 NULL,
	"Quantity_On_Hand" int4 NULL,
	"Quantity_Reserved" int4 NULL,
	"Quantity_Committed" int4 NULL,
	"Damaged_Qty" int4 NULL,
	"Returns_Qty" int4 NULL,
	"Avg_Daily_Sales" varchar(50) NULL,
	"Forecast_Next_30d" float4 NULL,
	"Days_of_Inventory" varchar(50) NULL,
	"Reorder_Point" float4 NULL,
	"Safety_Stock" int4 NULL,
	"Lead_Time_Days" int4 NULL,
	"Unit_Cost_USD" varchar(50) NULL,
	"Last_Purchase_Price_USD" varchar(50) NULL,
	"Total_Inventory_Value_USD" varchar(50) NULL,
	"SKU_Churn_Rate" varchar(50) NULL,
	"Order_Frequency_per_month" varchar(50) NULL,
	"Supplier_OnTime_Pct" varchar(50) NULL,
	"FIFO_FEFO" varchar(50) NULL,
	"Inventory_Status" varchar(50) NULL,
	"Count_Variance" int4 NULL,
	"Audit_Date" varchar(50) NULL,
	"Audit_Variance_Pct" varchar(50) NULL,
	"Demand_Forecast_Accuracy_Pct" varchar(50) NULL,
	"Notes" varchar(50) NULL
);