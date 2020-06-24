#!/bin/bash
## https://github.com/ajkis/scripts
DB="/opt/appdata/radarr4k/nzbdrone.db"

echo "$(date "+%d.%m.%Y %T") RADARR STATS"

QUERY="SELECT COUNT(*) FROM Movies"
RESULT=$(sqlite3 -header -line "$DB" "$QUERY")
echo "${RESULT:11} items in Movies"

QUERY="SELECT COUNT(*) FROM Movies WHERE Monitored = 1"
RESULT=$(sqlite3 -header -line "$DB" "$QUERY")
echo "${RESULT:11} items monitored"

QUERY="SELECT COUNT(*) FROM Movies WHERE id NOT IN (SELECT MovieId FROM MovieFiles)"
RESULT=$(sqlite3 -header -line "$DB" "$QUERY")
echo "${RESULT:11}  items missing"

echo "------------ QUALITY ------------"
QUERY="SELECT COUNT(*) FROM Movies WHERE id IN (SELECT MovieId FROM MovieFiles WHERE Quality LIKE '%: 31,%' )"
RESULT=$(sqlite3 -header -line "$DB" "$QUERY")
echo "${RESULT:11}    Remux  2160p movies"

QUERY="SELECT COUNT(*) FROM Movies WHERE id IN (SELECT MovieId FROM MovieFiles WHERE Quality LIKE '%: 19,%' )"
RESULT=$(sqlite3 -header -line "$DB" "$QUERY")
echo "${RESULT:11} BluRay 2160p movies"

QUERY="SELECT COUNT(*) FROM Movies WHERE id IN (SELECT MovieId FROM MovieFiles WHERE Quality LIKE '%: 18,%' )"
RESULT=$(sqlite3 -header -line "$DB" "$QUERY")
echo "${RESULT:11}   WEBDL  2160p movies"

QUERY="SELECT COUNT(*) FROM Movies WHERE id IN (SELECT MovieId FROM MovieFiles WHERE Quality LIKE '%: 16,%' )"
RESULT=$(sqlite3 -header -line "$DB" "$QUERY")
echo "${RESULT:11}  HDTV   2160p movies"

QUERY="SELECT COUNT(*) FROM Movies WHERE id IN (SELECT MovieId FROM MovieFiles WHERE Quality LIKE '%: 30,%' )"
RESULT=$(sqlite3 -header -line "$DB" "$QUERY")
echo "${RESULT:11}    Remux  1080p movies"

QUERY="SELECT COUNT(*) FROM Movies WHERE id IN (SELECT MovieId FROM MovieFiles WHERE Quality LIKE '%: 7,%' )"
RESULT=$(sqlite3 -header -line "$DB" "$QUERY")
echo "${RESULT:11} BluRay 1080p movies"

QUERY="SELECT COUNT(*) FROM Movies WHERE id IN (SELECT MovieId FROM MovieFiles WHERE Quality LIKE '%: 6,%' )"
RESULT=$(sqlite3 -header -line "$DB" "$QUERY")
echo "${RESULT:11}    BluRay  720p movies"

QUERY="SELECT COUNT(*) FROM Movies WHERE id IN (SELECT MovieId FROM MovieFiles WHERE Quality LIKE '%: 9,%' )"
RESULT=$(sqlite3 -header -line "$DB" "$QUERY")
echo "${RESULT:11}  HDTV   1080p movies"

QUERY="SELECT COUNT(*) FROM Movies WHERE id IN (SELECT MovieId FROM MovieFiles WHERE Quality LIKE '%: 4,%' )"
RESULT=$(sqlite3 -header -line "$DB" "$QUERY")
echo "${RESULT:11}  HDTV    720p movies"

QUERY="SELECT COUNT(*) FROM Movies WHERE id IN (SELECT MovieId FROM MovieFiles WHERE Quality LIKE '%: 3,%' )"
RESULT=$(sqlite3 -header -line "$DB" "$QUERY")
echo "${RESULT:11}   WEBDL  1080p movies"

QUERY="SELECT COUNT(*) FROM Movies WHERE id IN (SELECT MovieId FROM MovieFiles WHERE Quality LIKE '%: 5,%' )"
RESULT=$(sqlite3 -header -line "$DB" "$QUERY")
echo "${RESULT:11}   WEBDL   720p movies"

QUERY="SELECT COUNT(*) FROM Movies WHERE id IN (SELECT MovieId FROM MovieFiles WHERE Quality LIKE '%: 2,%' )"
RESULT=$(sqlite3 -header -line "$DB" "$QUERY")
echo "${RESULT:11}   DVD movies"

echo "------------ SIZE ---------------"
QUERY="SELECT COUNT(*) FROM MovieFiles WHERE Size > 15000000000"
RESULT=$(sqlite3 -header -line "$DB" "$QUERY")
echo "${RESULT:11}   movies above   15GB size"

QUERY="SELECT COUNT(*) FROM MovieFiles WHERE Size > 10000000000 AND Size < 15000000000"
RESULT=$(sqlite3 -header -line "$DB" "$QUERY")
echo "${RESULT:11} movies between 10GB - 15GB size"

QUERY="SELECT COUNT(*) FROM MovieFiles WHERE Size > 6000000000 AND Size < 10000000000"
RESULT=$(sqlite3 -header -line "$DB" "$QUERY")
echo "${RESULT:11} movies between 6GB - 10GB size"

QUERY="SELECT COUNT(*) FROM MovieFiles WHERE Size < 6000000000"
RESULT=$(sqlite3 -header -line "$DB" "$QUERY")
echo "${RESULT:11}  movies bellow  6GB size"

QUERY="SELECT sum(Size) FROM MovieFiles"
RESULT=$(sqlite3 -header -line "$DB" "$QUERY")
RESULT=$(numfmt --to=iec-i <<< ${RESULT:12})
echo "        Total size: $RESULT"

echo "------------ UNMATCHED MOVIES ---"
QUERY="SELECT Title from Movies WHERE MovieFileId = '0' AND id IN (SELECT MovieId FROM MovieFiles)"
RESULT=$(sqlite3 -header -line "$DB" "$QUERY")
echo "${RESULT:11}"
exit
