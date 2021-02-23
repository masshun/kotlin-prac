#!/bin/bash

cd "$(dirname "$0")"
echo "drop database prac" | psql -U postgres
echo "create databse prac" | psql -U postgres

psql -U postgres prac < ddl/create_prac.sql 2>&1 | grep -E "(NOTICE|ERROR|FATAL)"
psql -U postgres prac < ddl/create_sequence.sql 2>&1 | grep -E "(NOTICE|ERROR|FATAL)"