#!/bin/bash

file=$1

grep ^#include $file | grep -v tbtr | grep -v stdafx.h | sort
