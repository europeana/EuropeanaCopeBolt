## Make sure that we have one DEST_DIR across all npm scripts.
export DEST_DIR="/home/dropbox/dropboxsymlink/accessibility-reports/$(date '+%m-%Y')"
export SUMMARY_PATH="${DEST_DIR}/summary.json"

## Prepare the environment.
npm run accessibility:lighthouse:prepare

## Run the analyses
npm run accessibility:lighthouse:analyse

## Send emails
npm run accessibility:lighthouse:send
