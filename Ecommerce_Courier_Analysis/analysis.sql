-- Exploring the Data
SELECT * FROM Courier_Company_rates ccr;

SELECT * FROM Company_X_SKU_Mastert cxsm;

SELECT * FROM Courier_Company_Invoice cci;

SELECT * FROM 
 Company_X_Order_Report cxor 
join 
 Courier_Company_Invoice cci on cxor.ExternOrderNo = cci."Order ID";

/* The query performs an INNER JOIN operation between the "Company_X_Pincode_Zones" table (aliased as cxpz) 
 and the "Courier_Company_Invoice" table (aliased as cci). It joins the two tables on the condition that
 the "Customer Pincode" from both tables should match, and also the "Warehouse Pincode" from both tables should match.*/
SELECT cci."Order ID", cxpz."Customer Pincode" , cxpz.zone as company_x_zones, cci.zone as courier_comp_zone
FROM
  Company_X_Pincode_Zones cxpz
join 
  Courier_Company_Invoice cci ON cci."Customer Pincode"  = cxpz."Customer Pincode" 
  AND 
  cci."Warehouse Pincode" = cxpz."Warehouse Pincode" ;


/* SQL query calculates the total weight of each order from the "Company_X_Order_Report" and "Company_X_SKU_Master" 
 tables by performing an INNER JOIN between them. The JOIN is based on the "SKU" column, which links the 
 SKU information between the two tables. The query then groups the results by the "ExternOrderNo" (order ID) 
 and calculates the total weight for each order.*/
SELECT
  cxor.ExternOrderNo,
  SUM(cxsm."Weight (g)"  * cxor."Order Qty") AS TotalWeight
FROM
  Company_X_Order_Report cxor
JOIN
  Company_X_SKU_Mastert cxsm ON cxor.SKU = cxsm.SKU
GROUP BY
  cxor.ExternOrderNo;

 
 
/* Calculates the applicable weight for each order based on the provided logic and then retrieves various details 
 from the "Company_X_Order_Report," "Company_X_SKU_Master," "Courier_Company_Invoice," and "Courier_Company_Rates" tables.
 The output will provide detailed information for each order, including the applicable weight based on the provided logic.*/
  SELECT
  cxor.ExternOrderNo AS OrderID,
  cxor.SKU,
  cxor."Order Qty" ,
  cxor."Payment Mode",
  sku."Weight (g)"  AS GrossWeight,
  invoice.Zone,
  invoice."Charged Weight" ,
  rates."Weight Slabs" ,
  CASE
    WHEN sku."Weight (g)" <= rates."Weight Slabs" THEN sku."Weight (g)"
    ELSE rates."Weight Slabs"
  END AS ApplicableWeight
FROM
  company_x_order_report AS cxor
JOIN
  Company_X_SKU_Mastert AS sku ON cxor.SKU = sku.SKU
JOIN
  courier_company_invoice AS invoice ON cxor.ExternOrderNo = invoice."Order ID"
JOIN
  courier_company_rates AS rates ON invoice.Zone = LOWER(rates."Zone")
ORDER BY
  invoice."Order ID";

/* The query extends the previous query by adding an additional JOIN operation with the "Company_X_Pincode_Zones" 
 table (aliased as cxpz). This JOIN is based on the "Zone" column, and it links the delivery zone information between 
 the "Company_X_Pincode_Zones" and "Courier_Company_Invoice" tables.
 * The query includes a GROUP BY clause, which groups the results based on specific columns such as "ExternOrderNo" 
 (order ID), "AWB Code," "Delivery Zone as per X," "Delivery Zone charged by Courier Company," and other relevant columns.
 * The SELECT clause retrieves the same columns as in the previous query, along with the newly added "Delivery Zone as per X" 
 column, which represents the delivery zone information from the "Company_X_Pincode_Zones" table (cxpz).
 The results are ordered by the "Order ID" from the "Courier_Company_Invoice" table in ascending order (ORDER BY invoice."Order ID").*/
SELECT
  cxor.ExternOrderNo AS "Order ID",
  invoice."AWB Code" AS "AWB Number",
  SUM(sku."Weight (g)"  * cxor."Order Qty") / 1000 AS "Total weight as per X (KG)",
  rates."Weight Slabs" AS "Weight slab as per X (KG)",
  invoice."Charged Weight" AS "Total weight as per Courier Company (KG)",
  rates."Weight Slabs" AS "Weight slab charged by Courier Company (KG)",
  cxpz."Zone" AS "Delivery Zone as per X",
  invoice.Zone AS "Delivery Zone charged by Courier Company",
  CASE
    WHEN cxor."Payment Mode" = 'COD' THEN
      CASE
        WHEN cxor."Item Price(Per Qty.)" <= 300 THEN 15
        ELSE cxor."Item Price(Per Qty.)" * 0.05
      END
    ELSE 0
  END AS "COD charge",
  (rates."Forward Fixed Charge" + 
   (FLOOR(invoice."Charged Weight" / rates."Weight Slabs")) * rates."Forward Additional Weight Slab Charge") AS "Expected Charge as per X (Rs.)",
  invoice."Billing Amount (Rs.)" AS "Charges Billed by Courier Company (Rs.)",
  (rates."Forward Fixed Charge" + 
   (FLOOR(invoice."Charged Weight" / rates."Weight Slabs")) * rates."Forward Additional Weight Slab Charge")
   + 
   CASE
    WHEN cxor."Payment Mode" = 'COD' THEN
      CASE
        WHEN cxor."Item Price(Per Qty.)" <= 300 THEN 15
        ELSE cxor."Item Price(Per Qty.)" * 0.05
      END
    ELSE 0
  END
  - invoice."Billing Amount (Rs.)" AS "Difference Between Expected Charges and Billed Charges (Rs.)"
FROM
  company_x_order_report AS cxor
JOIN
  Company_X_SKU_Mastert AS sku ON cxor.SKU = sku.SKU
JOIN
  courier_company_invoice AS invoice ON cxor.ExternOrderNo = invoice."Order ID"
JOIN
  courier_company_rates AS rates ON invoice.Zone = LOWER(rates.Zone)
 JOIN Company_X_Pincode_Zones cxpz on cxpz."Zone" = invoice."Zone"
 GROUP BY
 cxor.ExternOrderNo, invoice."AWB Code", cxpz."Zone", invoice.Zone,
  cxor."Payment Mode", cxor."Item Price(Per Qty.)",
  sku."Weight (g)" , rates."Weight Slabs", invoice."Charged Weight", rates."Forward Fixed Charge", rates."Forward Additional Weight Slab Charge";
