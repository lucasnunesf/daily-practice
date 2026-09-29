import pandas as pd

# 0) Create the sample spreadsheet (so the exercise runs on its own)
data = {
    "Seller":  ["Ana", "Bruno", "Carla", "Diego", "Eva", "Fabio"],
    "Product": ["Laptop", "Mouse", "Monitor", "Keyboard", "Laptop", "Monitor"],
    "Region":  ["South", "South", "North", "South", "North", "South"],
    "Amount":  [3500, 80, 1200, 150, 3200, 1100],
}
pd.DataFrame(data).to_excel("sales.xlsx", index=False)

# 1) Read the original spreadsheet
df = pd.read_excel("sales.xlsx")

# 2) Filter: South region AND amount greater than 1000
mask = (df["Region"] == "South") & (df["Amount"] > 1000)
filtered_df = df[mask]

# 3) Save to another spreadsheet
filtered_df.to_excel("filtered_sales.xlsx", index=False)

print(filtered_df)
