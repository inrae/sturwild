#!/bin/bash
ROOT=install/pgsql
psql $ADDRESS -f "$ROOT/alter_24.1-25.0.sql"