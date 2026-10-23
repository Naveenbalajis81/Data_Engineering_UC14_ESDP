"""Sprint 3, step 2: profile every table in the staging and dw schemas.

Writes docs/profiling/profile_columns.csv (one row per column) and
docs/profiling/data_profiling_report.md (one section per table).

Setup (once):  pip install pandas sqlalchemy psycopg2-binary
Run from the repo root:
    set PGPASSWORD=root        (Git Bash: export PGPASSWORD=root)
    python sprint3/02_profile_tables.py
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
SCHEMAS = ["staging", "dw"]
OUT_DIR = Path("docs/profiling")

engine = create_engine(f"postgresql+psycopg2://{USER}:{PASSWORD}@{HOST}:{PORT}/{DB}")


def list_tables(conn):
    rows = conn.execute(text(
        "SELECT table_schema, table_name FROM information_schema.tables "
        "WHERE table_schema = ANY(:s) AND table_type = 'BASE TABLE' "
        "ORDER BY table_schema, table_name"), {"s": SCHEMAS})
    return rows.fetchall()


def profile_table(conn, schema, table):
    df = pd.read_sql(text(f'SELECT * FROM "{schema}"."{table}"'), conn)
    n = len(df)
    out = []
    for col in df.columns:
        s = df[col]
        nulls = int(s.isna().sum())
        non_null = s.dropna()
        out.append({
            "schema": schema, "table": table, "column": col,
            "dtype": str(s.dtype), "rows": n,
            "nulls": nulls,
            "null_pct": round(100 * nulls / n, 2) if n else 0.0,
            "distinct": int(non_null.nunique()),
            "min": str(non_null.min()) if len(non_null) else "",
            "max": str(non_null.max()) if len(non_null) else "",
        })
    # whole-row duplicates, ignoring surrogate keys that are always unique
    dup_cols = [c for c in df.columns if not c.endswith("_key")]
    dups = int(df.duplicated(subset=dup_cols).sum()) if dup_cols and n else 0
    return out, n, dups


def main():
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    all_cols, summary = [], []
    with engine.connect() as conn:
        for schema, table in list_tables(conn):
            cols, n, dups = profile_table(conn, schema, table)
            all_cols.extend(cols)
            summary.append((schema, table, n, len(cols), dups))
            print(f"{schema}.{table}: {n} rows, {len(cols)} columns, {dups} duplicate rows")

    cols_df = pd.DataFrame(all_cols)
    cols_df.to_csv(OUT_DIR / "profile_columns.csv", index=False)

    lines = ["# Data Profiling Report", "",
             f"Database `{DB}`, schemas: {', '.join(SCHEMAS)}.", "",
             "## Table summary", "",
             "| Schema | Table | Rows | Columns | Duplicate rows |", "|---|---|---:|---:|---:|"]
    for schema, table, n, c, d in summary:
        lines.append(f"| {schema} | {table} | {n:,} | {c} | {d} |")
    for (schema, table), g in cols_df.groupby(["schema", "table"], sort=True):
        lines += ["", f"## {schema}.{table}", "",
                  "| Column | Type | Nulls | Null % | Distinct | Min | Max |",
                  "|---|---|---:|---:|---:|---|---|"]
        for _, r in g.iterrows():
            lines.append(f"| {r['column']} | {r['dtype']} | {r['nulls']} | {r['null_pct']} | "
                         f"{r['distinct']} | {str(r['min'])[:30]} | {str(r['max'])[:30]} |")
    (OUT_DIR / "data_profiling_report.md").write_text("\n".join(lines), encoding="utf-8")
    print(f"\nWrote {OUT_DIR / 'profile_columns.csv'} and {OUT_DIR / 'data_profiling_report.md'}")


if __name__ == "__main__":
    main()
