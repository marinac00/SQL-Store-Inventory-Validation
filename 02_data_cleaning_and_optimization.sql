/* -------------------------------------------------------------------------
   ARCHIVO 02: LIMPIEZA Y NORMALIZACIÓN TEMPORAL
   Objetivo: 
   1. Corregir formatos (Moneda/Comas).
   2. Sincronizar fechas a HOY (Time Shift).
   3. Eliminar columnas redundantes/estáticas.
   4. Sincronización a fecha actual para que los datos ficticios sean usables.
   ------------------------------------------------------------------------- */

-- 1. LIMPIEZA DE FORMATOS (eliminar símbolo $; cambio , por . decimal) y conversión de números
ALTER TABLE produkt 
    -- Limpieza blindada con ::TEXT por si DBeaver/pgAdmin discrepan
    ALTER COLUMN "Quantity_On_Hand" TYPE INTEGER 
        USING (REPLACE(REPLACE("Quantity_On_Hand"::TEXT, '.', ''), ',', '')::INTEGER),
    ALTER COLUMN "Unit_Cost_USD" TYPE DECIMAL(10,2) 
        USING (REPLACE(REPLACE("Unit_Cost_USD"::TEXT, '$', ''), ',', '.')::DECIMAL(10,2));

ALTER TABLE produkt 
    ALTER COLUMN "Avg_Daily_Sales" TYPE DECIMAL(10,2) 
    USING (REPLACE("Avg_Daily_Sales"::TEXT, ',', '.')::DECIMAL(10,2));

-- 2. CONVERSIÓN DE FECHAS
ALTER TABLE produkt 
    ALTER COLUMN "Received_Date" TYPE DATE USING "Received_Date"::DATE,
    ALTER COLUMN "Expiry_Date" TYPE DATE USING "Expiry_Date"::DATE,
    ALTER COLUMN "Last_Purchase_Date" TYPE DATE USING "Last_Purchase_Date"::DATE;

-- 3. ELIMINACIÓN DE COLUMNAS ESTÁTICAS (Limpieza de ruido)
ALTER TABLE produkt DROP COLUMN IF EXISTS "Stock_Age_Days";
ALTER TABLE produkt DROP COLUMN IF EXISTS "Total_Inventory_Value_USD";
ALTER TABLE produkt DROP COLUMN IF EXISTS "Days_of_Inventory";

-- 4. SINCRONIZAR A HOY
-- Definir variable con los días de diferecia entre la última fecha de recepción de pedido y hoy.
DO $$ 
DECLARE 
    dias_desfase INTEGER;
BEGIN
    SELECT (CURRENT_DATE - MAX("Received_Date")) INTO dias_desfase FROM produkt;

    UPDATE produkt 
    SET 
	-- La última fecha de pedio pasa a ser hoy
        "Received_Date" = "Received_Date" + dias_desfase,
        "Expiry_Date" = "Expiry_Date" + dias_desfase,
        "Last_Purchase_Date" = "Last_Purchase_Date" + dias_desfase;
END $$;