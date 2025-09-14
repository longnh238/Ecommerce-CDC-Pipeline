import psycopg2
import random
import time
import uuid

conn = psycopg2.connect(database="ecommerce", user="postgres", password="secret123", host="localhost", port="5432")
cur = conn.cursor()
for _ in range(1000):
    cur.execute("SELECT product_id FROM inventory ORDER BY RANDOM() LIMIT 1")
    product_id = cur.fetchone()[0]
    new_stock = random.randint(0, 1000)
    cur.execute(
        "UPDATE inventory SET stock_level = %s, last_updated = NOW() WHERE product_id = %s",
        (new_stock, product_id)
    )
    conn.commit()
    time.sleep(0.06)  # ~1000 events/min
conn.close()
print("Simulation complete.")