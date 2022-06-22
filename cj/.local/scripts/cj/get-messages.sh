
for i in {1..5000}
do

  aws sqs --region=us-west-1 receive-message \
          --queue-url=https://sqs.us-west-1.amazonaws.com/900394040587/order-service-orderrestatementrequestqueue35842406-1Q61UQQ5EVJDT \
          > $(uuidgen).json 

done
