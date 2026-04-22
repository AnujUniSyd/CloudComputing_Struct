#!/bin/bash

if ! command -v psql >/dev/null 2>&1; then
    echo "Error: psql is not installed."
    echo "On Amazon Linux, install it with: sudo yum install postgresql15"
    exit 1
fi

PGHOST="localhost"
PGPORT="5433"
PGDATABASE="postgres"
PGUSER="postgres"
PGPASSWORD="2401"

export PGPASSWORD

psql -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -d "$PGDATABASE" <<EOF
CREATE TABLE IF NOT EXISTS documents (
    id SERIAL PRIMARY KEY,
    filename VARCHAR(255) NOT NULL,
    s3_key TEXT NOT NULL,
    summary TEXT,
    status VARCHAR(50) NOT NULL DEFAULT 'completed',
    uploaded_at TIMESTAMP NOT NULL
);
EOF

echo "Table 'documents' created successfully."
