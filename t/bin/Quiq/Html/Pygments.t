#!/usr/bin/env perl

package Quiq::Html::Pygments::Test;
use base qw/Quiq::Test::Class/;

use strict;
use warnings;
use v5.10.0;

use Quiq::Path;
use Quiq::Unindent;

# -----------------------------------------------------------------------------

sub test_loadClass : Init(1) {
    shift->useOk('Quiq::Html::Pygments');
}

# -----------------------------------------------------------------------------

sub test_unitTest : Test(4) {
    my $self = shift;

    if (!Quiq::Path->findProgram('pygmentize',1)) {
        $self->skipAllTests('Program pygmentize not found');
        return;
    }

    # CSS

    my ($rules,$bgColor) = Quiq::Html::Pygments->css;
    $self->like($rules,qr/^\.[a-z]+/);
    $self->like($bgColor,qr/^#[0-9A-Fa-f]{6}/);

    # HTML

    my $html = Quiq::Html::Pygments->html('perl',
        Quiq::Unindent->trimNl(q~
            print "Hello, world!\n";
        ~),
    );
    $self->like($html,qr/Hello, world!/);

    # Styles durchtesten (es darf keine Exception geben, weil der
    # Style nicht bekannt ist oder die Hintergrundfarbe nicht
    # bestimmt werden kann)

    my $n = 0;
    for my $style (Quiq::Html::Pygments->styles) {
        $n++;
        my ($rules,$bgColor) = Quiq::Html::Pygments->css($style);
    }
    $self->ok($n);
}

# -----------------------------------------------------------------------------

package main;
Quiq::Html::Pygments::Test->runTests;

# eof
