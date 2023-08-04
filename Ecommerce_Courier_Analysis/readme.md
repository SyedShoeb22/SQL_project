# Ecommerce Courier Analysis

## Overview

This repository contains the code and resources for the Ecommerce Courier Analysis project. The project aims to verify the charges levied by courier companies for delivering orders for an Indian ecommerce company ("X"). By analyzing data from various sources, including order reports, SKU master, courier invoices, and rate cards, the project determines whether the charges applied by the courier partners are correct.

## Business Scenario

Company X receives thousands of orders daily and partners with multiple courier companies in India for order deliveries. The courier charges are dependent on factors such as product weight, product price, and distance between the warehouse and the customer's address. The total courier charges amount to a significant sum, and Company X wants to ensure the accuracy of these charges to avoid overcharging or undercharging.

## Data Sources

The data for this analysis is provided in separate Excel files:

1. `company_x_order_report.xlsx`: Contains information about orders, SKUs, payment mode, and item prices.
2. `company_x_pincode_zones.xlsx`: Maps warehouse and customer pincodes to delivery zones.
3. `company_x_sku_master.xlsx`: Provides the gross weight of each SKU.
4. `courier_company_invoice.xlsx`: Includes courier company invoices with order-specific charges, weights, and delivery zones.
5. `courier_company_rates.xlsx`: Rate card with weight slabs, fixed charges, and additional weight charges.

## Analysis Steps

The project follows the following steps:

1. Calculate the total weight of each order based on SKU weight and quantity.
2. Determine the applicable weight slab for each order based on the delivery zone.
3. Calculate the COD charges for applicable orders.
4. Compare the expected charges based on the rate card with the actual charges billed by the courier companies.
5. Prepare a summary table with counts and amounts for overcharged, undercharged, and correctly charged orders.

## Files and Folders

- `code/`: Contains SQL queries used for data analysis.
- `data/`: Contains the Excel data files used for the analysis.
- `results/`: Includes the output summary table and any other relevant results.

## How to Use

1. Clone the repository to your local machine.
2. Ensure you have a SQL server installed, and the required libraries are available.
3. Run the SQL queries in the `code/` folder against the provided data in the `data/` folder.
4. Review the summary table and other results in the `results/` folder.

## License

The project is available under the [MIT License](LICENSE.md).

## Contact

For any questions or feedback regarding the project, please contact:

Syed Shoeb
Email: syedshoeb8380@gmail.com
