#!/bin/bash -e

source test.functions

testKraftDefaults() {
	echo "testKraftDefaults"

	# Given KRaft mode and no ZooKeeper
	export KAFKA_ENABLE_KRAFT=true
	unset KAFKA_ZOOKEEPER_CONNECT
	unset KAFKA_NODE_ID
	unset KAFKA_PROCESS_ROLES
	unset KAFKA_CONTROLLER_LISTENER_NAMES
	unset KAFKA_CONTROLLER_QUORUM_VOTERS
	unset KAFKA_LISTENERS

	# When the script is invoked
	source "$START_KAFKA"

	# Then default KRaft settings are injected
	assertExpectedConfig 'node.id=1'
	assertExpectedConfig 'process.roles=broker,controller'
	assertExpectedConfig 'controller.listener.names=CONTROLLER'
	assertExpectedConfig 'listener.security.protocol.map=PLAINTEXT:PLAINTEXT,CONTROLLER:PLAINTEXT'
	assertExpectedConfig "controller.quorum.voters=1@${HOSTNAME}:9093"
}

testKraftDefaults
