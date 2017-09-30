#!/bin/bash
#

# Update LD_LIBRARY_PATH to allow the swift binary to load shared libraries
export LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH

./usr/bin/swift
