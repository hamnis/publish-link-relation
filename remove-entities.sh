#!/bin/bash
perl -i -pe 'BEGIN{undef $/;} s/<!DOCTYPE rfc SYSTEM .*\]>/<!DOCTYPE rfc SYSTEM "rfc2629.dtd">/smg' draft-expanded.xml