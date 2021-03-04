## Make sure that we have one DEST_DIR across all npm scripts.
export DEST_DIR=./reports/$(date "+%m-%Y")

npm run accessibility:lighthouse:prepare
npm run accessibility:lighthouse:analyse
npm run accessibility:lighthouse:send
