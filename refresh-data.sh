#!/bin/bash
# Refresh all cached Metabase data for growth plan generation
# Usage: ./refresh-data.sh

MB_TOKEN="mb_zTJkmRY5F7KhSfKJR20I2cSCUyvAxf70dZWHI+tBMC8="
MB_URL="https://maven.metabaseapp.com"
DIR="$(cd "$(dirname "$0")" && pwd)/data"

echo "Refreshing data into $DIR..."

echo "  Lightning Lessons (6859)..."
curl -s -H "x-api-key: $MB_TOKEN" "$MB_URL/api/card/6859/query/json" -X POST > "$DIR/lightning_lessons.json"

echo "  Course Syllabus (15271)..."
curl -s -H "x-api-key: $MB_TOKEN" "$MB_URL/api/card/15271/query/json" -X POST > "$DIR/course_syllabus.json"

echo "  GMV by Course (3887)..."
curl -s -H "x-api-key: $MB_TOKEN" "$MB_URL/api/card/3887/query/json" -X POST > "$DIR/gmv_by_course.json"

echo "  LL Signups by School (4081)..."
curl -s -H "x-api-key: $MB_TOKEN" "$MB_URL/api/card/4081/query/json" -X POST > "$DIR/ll_signups_by_school.json"

echo "  Lead Magnets (15864)..."
curl -s -H "x-api-key: $MB_TOKEN" "$MB_URL/api/card/15864/query/json" -X POST > "$DIR/lead_magnets.json"

echo "Done. Refreshed at $(date)"
