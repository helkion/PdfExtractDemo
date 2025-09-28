#!/usr/bin/env bash
# Simple script to help testing: uses sendmail or mailx tool installed locally
# English comments in code


TO="$1"
FILE="$2"
SUBJECT="Test PDF upload"
BODY="Test email with PDF attachment sent from script."


if [ -z "$TO" ] || [ -z "$FILE" ]; then
echo "Usage: $0 recipient@example.com /path/to/file.pdf"
exit 1
fi


# Try mailx
if command -v mailx >/dev/null 2>&1; then
echo "$BODY" | mailx -s "$SUBJECT" -a "$FILE" "$TO"
exit $?
fi


# Try sendmail fallback (very basic)
if command -v sendmail >/dev/null 2>&1; then
boundary="ZZ_/afg6432dfgkl.94531"
{
printf "From: test@example.com\n"
printf "To: %s\n" "$TO"
printf "Subject: %s\n" "$SUBJECT"
printf "MIME-Version: 1.0\n"
printf "Content-Type: multipart/mixed; boundary=\"%s\"\n" "$boundary"
printf "\n--%s\n" "$boundary"
printf "Content-Type: text/plain; charset=us-ascii\n\n"
printf "%s\n" "$BODY"
printf "\n--%s\n" "$boundary"
printf "Content-Type: application/pdf; name=\"%s\"\n" "$(basename "$FILE")"
printf "Content-Transfer-Encoding: base64\n"
printf "Content-Disposition: attachment; filename=\"%s\"\n\n" "$(basename "$FILE")"
base64 "$FILE"
printf "\n--%s--\n" "$boundary"
} | sendmail -t
exit $?
fi


echo "No mail client (mailx/sendmail) found. Please use your normal mail client to send the PDF to the monitored mailbox."
