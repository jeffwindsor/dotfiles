FILE=$1
body=$(cat "$FILE" | jq '.Messages[0].Body' | sed 's/\\//g' | sed "s/^\"//"| sed "s/\"$//")
echo $FILE
echo $body

aws sqs --region=us-west-1 send-message \
        --queue-url=https://sqs.us-west-1.amazonaws.com/845290112482/order-service-orderrestatementrequestqueue35842406-HPVV1MV1R3WS \
        --message-body="$body"
