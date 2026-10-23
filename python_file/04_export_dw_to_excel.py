"""Export all 17 dw tables to one Excel workbook (one sheet per table) for Power BI.

Setup (once):  pip install pandas sqlalchemy psycopg2-binary openpyxl
Run from the repo root:
    export PGPASSWORD=root
    python sprint3/04_export_dw_to_excel.py
Output: powerbi_data/uc14_dw.xlsx
"""
import os
from pathlib import Path

import pandas as pd
from sqlalchemy import create_engine, text

HOST = os.getenv("PGHOST", "localhost")
PORT = os.getenv("PGPORT", "5432")
DB = os.getenv("PGDATABASE", "uc14_esdp")
USER = os.getenv("PGUSER", "postgres")
PASSWORD = os.getenv("PGPASSWORD", "")
OUT = Path("powerbi_data/uc14_dw.xlsx")

engine = create_engine(f"postgresql+psycopg2://{USER}:{PASSWORD}@{HOST}:{PORT}/{DB}")
OUT.parent.mkdir(exist_ok=True)

with engine.connect() as conn:
    tables = [r[0] for r in conn.execute(text(
        "SELECT table_name FROM information_schema.tables "
        "WHERE table_schema = 'dw' AND table_type = 'BASE TABLE' ORDER BY table_name"))]
    with pd.ExcelWriter(OUT, engine="openpyxl") as writer:
        for t in tables:
            df = pd.read_sql(text(f'SELECT * FROM dw."{t}"'), conn)
            df.to_excel(writer, sheet_name=t[:31], index=False)
            print(f"{t}: {len(df)} rows")
print(f"\nWrote {OUT} with {len(tables)} sheets")
