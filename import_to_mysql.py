import pandas as pd
import mysql.connector

csv_file = r"C:\Users\tamal\Desktop\CTPO The Finale\Clinical-Trials-Analytic-Presicion-Oncology-main\Data\trials_master_ANNOTATED.csv"

df = pd.read_csv(csv_file)

print("CSV loaded:", df.shape)

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="YOUR_CONNECTION_PASSWORD",
    database="ctpo"
)

cursor = conn.cursor()

df = df.astype(object).where(pd.notnull(df), None)

columns = list(df.columns)

column_names = ", ".join(f"`{col}`" for col in columns)
placeholders = ", ".join(["%s"] * len(columns))

sql = f"""
INSERT INTO clinical_trials ({column_names})
VALUES ({placeholders})
"""

batch_size = 1000

for start in range(0, len(df), batch_size):

    batch = df.iloc[start:start + batch_size]

    data = [
        tuple(row)
        for row in batch.itertuples(index=False, name=None)
    ]

    cursor.executemany(sql, data)
    conn.commit()

    print(f"Inserted {min(start + batch_size, len(df))}/{len(df)} rows")

cursor.close()
conn.close()

print("Import completed successfully!")
