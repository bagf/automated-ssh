#!/bin/bash

echo "Please enter MAC:"
read MAC
echo "and shared pass:"
read PASS

md5 -s "$MAC:$PASS"
