#!/usr/bin/env sh

DB="$HOME/Library/Group Containers/group.net.whatsapp.WhatsApp.shared/ChatStorage.sqlite"
ICON=""

TOTAL=$(sqlite3 "$DB" \
  'SELECT COALESCE(SUM(ZUNREADCOUNT), 0)
   FROM ZWACHATSESSION
   WHERE ZUNREADCOUNT > 0
     AND ZCONTACTJID NOT LIKE "%@status";' \
  2>/dev/null)

DETAILS=$(sqlite3 -separator '|' "$DB" \
  'SELECT COALESCE(ZPARTNERNAME, ZCONTACTJID), ZUNREADCOUNT
   FROM ZWACHATSESSION
   WHERE ZUNREADCOUNT > 0
     AND ZCONTACTJID NOT LIKE "%@status"
   ORDER BY ZPARTNERNAME;' \
  2>/dev/null |
  awk -F'|' '
    {
      n = split($1, words, " ")
      initials = ""
      for (i = 1; i <= n; i++) {
        if (words[i] != "")
          initials = initials toupper(substr(words[i], 1, 1))
      }

      if (out != "") out = out ", "
      out = out initials " " $2
    }
    END { print out }
  ')

if [ "$TOTAL" -gt 0 ]; then
  sketchybar --set "$NAME" \
    drawing=on \
    icon="$ICON" \
    label="$TOTAL | $DETAILS"
else
  sketchybar --set "$NAME" drawing=off
fi
