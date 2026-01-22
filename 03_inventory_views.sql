/* -------------------------------------------------------------------------
   VIEW 1: DEAD STOCK AUDIT / AUDITORÍA DE STOCK MUERTO
   
   ES: Detectar capital inmovilizado en productos de larga duración con cobertura excesiva o ventas cero.
   EN: Detect locked capital in long-lasting products with excessive coverage or zero sales.
   ------------------------------------------------------------------------- */

DROP VIEW IF EXISTS v_dead_stock_audit;

CREATE VIEW v_dead_stock_audit AS
SELECT 
    "SKU_Name",
    "Category",
    "Warehouse_Location",
    "Quantity_On_Hand" AS current_stock,
    "Unit_Cost_USD" AS unit_cost,
    
    -- 1. KPI: DINERO BLOQUEADO ($)
    ("Quantity_On_Hand" * "Unit_Cost_USD") AS locked_capital,
    
    -- 2. KPI: VENTA DIARIA
    "Avg_Daily_Sales" AS avg_daily_sales,
    
    -- 3. KPI: DÍAS DE COBERTURA (Stock / Ventas)
    CASE 
        WHEN "Avg_Daily_Sales" <= 0 THEN 9999 -- Zombie Safety Net
        ELSE ROUND("Quantity_On_Hand" / "Avg_Daily_Sales", 1)
    END AS actual_coverage_days,

    -- 4. SEMÁFORO DE RIESGO
    CASE 
        WHEN "Avg_Daily_Sales" <= 0 THEN '🔴 ZOMBIE (0 Sales)'
        WHEN ("Quantity_On_Hand" / "Avg_Daily_Sales") > 180 THEN '🔴 TOXIC (> 6 Months)'
        WHEN ("Quantity_On_Hand" / "Avg_Daily_Sales") BETWEEN 60 AND 180 THEN '🟡 EXCESS (2-6 Months)'
        ELSE '🟢 HEALTHY (< 2 Months)'
    END AS financial_status

FROM produkt
-- Filtramos frescos para centrarnos en Stock Muerto de larga duración
WHERE "Category" NOT IN ('Fresh Produce', 'Meat', 'Dairy', 'Seafood', 'Bakery');