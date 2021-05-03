#!/bin/bash

if [ "$PAM_TYPE" != "close_session" ]; then
        url_slack=<webhook>
        url_telegram=<https://api.telegram.org/bot<token>/sendmessage>
        chat_id=<#>
        channel=<n>
        host="$(hostname)"
        content="\"attachments\": [ { \"mrkdwn_in\": [\"text\", \"fallback\"], \"fallback\": \"SSH login: $PAM_USER connected to \`$host\`\", \"text\": \"SSH login to \`$host\`\", \"fields\": [ { \"title\": \"User\", \"value\": \"$PAM_USER\", \"short\": true }, { \"title\": \"IP Address\", \"value\": \"$PAM_RHOST\", \"short\": true } ], \"color\": \"#F35A00\" } ]"
		text="SSH login: <b>$PAM_USER</b> on <b>$host</b> <b>$PAM_RHOST</b>"
        curl -X POST --data-urlencode "payload={\"channel\": \"$channel\", \"mrkdwn\": true, \"username\": \"SSH Login\", $content}" "$url_slack" &
        curl --location --request POST "$url_telegram?chat_id=$chat_id&text=$text&parse_mode=html" &
fi
exit