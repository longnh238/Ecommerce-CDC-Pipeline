from faker import Faker
import csv
import random
from datetime import datetime

fake = Faker()
csv_path = 'inventory.csv'
with open(csv_path, 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['product_name', 'category', 'stock_level', 'price', 'last_updated'])  # No product_id (auto-gen)
    for i in range(1000):
        writer.writerow([
            fake.word().title() + ' ' + fake.word().title(),  # e.g., "Quick Fox"
            random.choice(['Electronics', 'Clothing', 'Books', 'Home']),
            random.randint(0, 1000),
            round(random.uniform(1.0, 500.0), 2),
            fake.date_time_this_year().isoformat()
        ])
print(f"Generated {csv_path} with 1000 rows.")