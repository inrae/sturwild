#!/bin/bash
ROOT=install/pgsql
psql $ADDRESS -f "$ROOT/alter_23.0-24.0.sql"