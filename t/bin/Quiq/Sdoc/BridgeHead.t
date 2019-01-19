#!/usr/bin/env perl

package Quiq::Sdoc::BridgeHead::Test;
use base qw/Quiq::Test::Class/;

use strict;
use warnings;
use v5.10.0;

# -----------------------------------------------------------------------------

sub test_loadClass : Init(1) {
    shift->useOk('Quiq::Sdoc::BridgeHead');
}

# -----------------------------------------------------------------------------

package main;
Quiq::Sdoc::BridgeHead::Test->runTests;

# eof
