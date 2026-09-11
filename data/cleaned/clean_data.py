import pandas as pd
from pathlib import Path

# --------------------------------------------------
# Paths
# --------------------------------------------------

BASE_DIR = Path(__file__).resolve().parent.parent
RAW_FILE = BASE_DIR / "raw" / "supply_chain_data.csv"
CLEAN_DIR = BASE_DIR / "cleaned"
CLEAN_FILE = CLEAN_DIR / "supply_chain_cleaned.csv"

# Create cleaned folder if it doesn't exist
CLEAN_DIR.mkdir(parents=True, exist_ok=True)

# --------------------------------------------------
# Load raw data
# --------------------------------------------------

df = pd.read_csv(RAW_FILE)

print("Original shape:", df.shape)

# --------------------------------------------------
# Standardize column names
# --------------------------------------------------

df.columns = [
    "product_type",
    "sku",
    "price",
    "availability",
    "products_sold",
    "revenue",
    "customer_demographics",
    "stock_levels",
    "supplier_lead_time",
    "order_quantity",
    "shipping_time",
    "shipping_carrier",
    "shipping_cost",
    "supplier_name",
    "supplier_location",
    "lead_time",
    "production_volume",
    "manufacturing_lead_time",
    "manufacturing_cost",
    "inspection_result",
    "defect_rate",
    "transportation_mode",
    "route",
    "logistics_cost"
]

# --------------------------------------------------
# Remove accidental whitespace from text fields
# --------------------------------------------------

text_columns = df.select_dtypes(include="object").columns

for col in text_columns:
    df[col] = df[col].astype(str).str.strip()

# --------------------------------------------------
# Remove duplicate rows
# --------------------------------------------------

before_duplicates = len(df)

df = df.drop_duplicates()

after_duplicates = len(df)

print("Duplicates removed:", before_duplicates - after_duplicates)

# --------------------------------------------------
# Handle missing values
# --------------------------------------------------

missing_before = df.isna().sum().sum()

print("Missing values before cleaning:", missing_before)

# No missing values are expected in this dataset.
# We do not artificially fill values.

# --------------------------------------------------
# Convert numeric columns
# --------------------------------------------------

numeric_columns = [
    "price",
    "availability",
    "products_sold",
    "revenue",
    "stock_levels",
    "supplier_lead_time",
    "order_quantity",
    "shipping_time",
    "shipping_cost",
    "lead_time",
    "production_volume",
    "manufacturing_lead_time",
    "manufacturing_cost",
    "defect_rate",
    "logistics_cost"
]

for col in numeric_columns:
    df[col] = pd.to_numeric(df[col], errors="coerce")

# --------------------------------------------------
# Basic validation
# --------------------------------------------------

print("\nFinal shape:", df.shape)

print("\nMissing values after cleaning:")
print(df.isna().sum().sum())

print("\nDuplicate rows after cleaning:")
print(df.duplicated().sum())

print("\nData types:")
print(df.dtypes)

# --------------------------------------------------
# Save cleaned dataset
# --------------------------------------------------

df.to_csv(CLEAN_FILE, index=False)

print("\nCleaned dataset saved to:")
print(CLEAN_FILE)