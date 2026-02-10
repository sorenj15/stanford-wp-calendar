#!/bin/bash
# Quick script to create and publish a new calendar event
# Usage: ./add-event.sh "event-name-2026" "Event Title" "20260410" "20260413" "Location"

if [ $# -lt 5 ]; then
  echo "Usage: ./add-event.sh <filename> <title> <start-YYYYMMDD> <end-YYYYMMDD> <location>"
  echo "Example: ./add-event.sh pacific-cup-2026 'Stanford Water Polo - Pacific Cup' 20260410 20260413 'University of the Pacific, Stockton, CA'"
  exit 1
fi

FILENAME="$1"
TITLE="$2"
START="$3"
END="$4"
LOCATION="$5"

# Escape commas in location for ICS format
ICS_LOCATION=$(echo "$LOCATION" | sed 's/,/\\,/g')

cat > "events/${FILENAME}.ics" << EOF
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//Stanford Men's Water Polo//Calendar//EN
CALSCALE:GREGORIAN
METHOD:PUBLISH
BEGIN:VEVENT
DTSTART;VALUE=DATE:${START}
DTEND;VALUE=DATE:${END}
SUMMARY:${TITLE}
LOCATION:${ICS_LOCATION}
DESCRIPTION:Stanford Men's Water Polo - ${TITLE}
STATUS:CONFIRMED
SEQUENCE:0
END:VEVENT
END:VCALENDAR
EOF

echo "Created events/${FILENAME}.ics"
echo ""
echo "Publishing..."
git add "events/${FILENAME}.ics"
git commit -m "Add ${TITLE} calendar event"
git push

echo ""
echo "Done! Link: https://sorenj15.github.io/stanford-wp-calendar/events/${FILENAME}.ics"
