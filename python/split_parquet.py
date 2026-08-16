import pandas as pd
from pathlib import Path

# Paths
INPUT_FILE = Path("data/yellow_tripdata_2025-01.parquet")
OUTPUT_DIR = Path("data/taxi_trips")

# Create output directory
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

# Read parquet
df = pd.read_parquet(INPUT_FILE)

print("Original rows:", len(df))
print("\nOriginal columns:")
print(df.columns.tolist())

# Keep only columns useful for our project
df = df[
    [
        "VendorID",
        "tpep_pickup_datetime",
        "tpep_dropoff_datetime",
        "passenger_count",
        "trip_distance",
        "RatecodeID",
        "PULocationID",
        "DOLocationID",
        "payment_type",
        "fare_amount",
        "tip_amount",
        "tolls_amount",
        "total_amount",
    ]
].copy()

# Create a unique trip ID
df.insert(0, "trip_id", range(1, len(df) + 1))

# Keep a manageable dataset
df = df.head(70000)

print("\nRows after filtering:", len(df))
print("\nFinal schema:")
print(df.dtypes)

# Split into 7 approximately equal files
chunks = [chunk for chunk in df.groupby(df.index // 10000)]

for i, (_, chunk) in enumerate(chunks, start=1):
    output_file = OUTPUT_DIR / f"taxi_trips_{i:02d}.parquet"
    chunk.to_parquet(output_file, index=False)
    print(f"Created: {output_file} | Rows: {len(chunk)}")

print("\nDone!")