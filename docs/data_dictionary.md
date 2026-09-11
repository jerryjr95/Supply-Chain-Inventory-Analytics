# Supply Chain Analytics — Data Dictionary

## Dataset Overview

- Records: 100
- Columns: 24
- Missing values: 0
- Duplicate rows: 0
- Date field: None

The dataset supports inventory, product, supplier, logistics, manufacturing, and quality analysis.

## Field Mapping

| Source Field | Cleaned Field | Data Type | Description |
|---|---|---|---|
| Product type | `product_type` | Text | Product category/type |
| SKU | `sku` | Text | Product/SKU identifier |
| Price | `price` | Numeric | Product price |
| Availability | `availability` | Numeric | Availability value supplied by source |
| Number of products sold | `products_sold` | Numeric | Number of products sold |
| Revenue generated | `revenue` | Numeric | Revenue supplied by source |
| Customer demographics | `customer_demographics` | Text | Customer demographic category |
| Stock levels | `stock_levels` | Numeric | Inventory/stock level |
| Lead times | `supplier_lead_time` | Numeric | Source lead-time field |
| Order quantities | `order_quantities` | Numeric | Order quantity |
| Shipping times | `shipping_time` | Numeric | Shipping time |
| Shipping carriers | `shipping_carrier` | Text | Shipping carrier |
| Shipping costs | `shipping_cost` | Numeric | Shipping cost |
| Supplier name | `supplier_name` | Text | Supplier name |
| Location | `supplier_location` | Text | Supplier location |
| Lead time | `lead_time` | Numeric | Second source lead-time field |
| Production volumes | `production_volumes` | Numeric | Production volume |
| Manufacturing lead time | `manufacturing_lead_time` | Numeric | Manufacturing lead time |
| Manufacturing costs | `manufacturing_cost` | Numeric | Manufacturing cost |
| Inspection results | `inspection_result` | Text | Inspection result/category |
| Defect rates | `defect_rate` | Numeric | Defect-rate value from source |
| Transportation modes | `transportation_mode` | Text | Transportation mode |
| Routes | `route` | Text | Route/category |
| Costs | `logistics_cost` | Numeric | Additional cost field |

## Modeling Notes

### No artificial time series
The source dataset has no date field, so no artificial monthly or yearly trends are created.

### Revenue
Revenue is analyzed using the source `revenue` field. It is not recalculated as `price × products_sold` because the source values do not consistently match that calculation.

### Lead times
`Lead times` and `Lead time` are retained separately as `supplier_lead_time` and `lead_time`.

### Costs
`Shipping costs` and `Costs` are retained separately as `shipping_cost` and `logistics_cost`.

### Defect rate
The source defect-rate values are percentage-point values. For example, a source average of about `2.28` represents about `2.28%`. The Power BI percentage measure divides the source value by 100 before percentage formatting.
