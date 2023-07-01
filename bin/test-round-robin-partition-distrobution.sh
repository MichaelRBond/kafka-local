#!/usr/bin/env bash

# Test to see how keys / partitions behave.
#
# While testing with to following command it was observed that the same key is landing in different
# partitions
# kafka-console-producer --bootstrap-server localhost:9092 --topic foo --producer-property partitioner.class=org.apache.kafka.clients.producer.RoundRobinPartitioner --property parse.key=true --property key.separator=:
#
# The expected behavior was that the same key is is on the same partition.
# Hypothesis: Because round robin was specified, it is explicitly using a partiion id to send data
# instead of the key hash
#
# This script is to attempt further test this behavior
#
# Results:
# Produces to multiple partitions: kafka-console-producer --broker-list localhost:9092 --topic foo1 --producer-property partitioner.class=org.apache.kafka.clients.producer.RoundRobinPartitioner --property parse.key=true --property key.separator=: < key_test2.txt
# Produces to single partition: kafka-console-producer --broker-list localhost:9092 --topic foo1 --property parse.key=true --property key.separator=: < key_test.txt

for i in {1..10000}
do
  echo "truck:bar" >> key_test2.txt
done
