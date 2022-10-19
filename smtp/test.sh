#!/usr/bin/env bash

if [ $# -lt 1 ]; then
  echo
  echo "Usage: $0 RECIPIENT [SUBJECT] [MESSAGE]"
  echo
  exit 1
fi

HOST="email-smtp.us-east-1.amazonaws.com"
. credentials.sh

RECIPIENT="$1"

SUBJECT=${2:-SES SMTP Test}
BODY=${3:-This message was sent using the SES SMTP interface.}

openssl s_client -crlf -quiet -starttls smtp -connect ${HOST}:587 << EOM
EHLO forums.tropy.org
AUTH LOGIN
$(echo -n "$USER" | openssl enc -base64)
$(echo -n "$PASSWORD" | openssl enc -base64)
MAIL FROM: no-reply@forums.tropy.org
RCPT TO: $RECIPIENT
DATA
From: Tropy Forums <no-reply@forums.tropy.org>
To: $RECIPIENT
Subject: $SUBJECT

$BODY
.
QUIT
EOM
