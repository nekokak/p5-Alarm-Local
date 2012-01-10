#!perl -w
use strict;
use warnings;
use Test::More;
use Alarm::Nest qw(localalarm);

my $fire=0;
$SIG{ALRM} = sub {
    ++$fire;
    note 'fire';
};

do {
    my $la = localalarm(5);
    is $la, 0;

    do {
        my $la = localalarm(1);
        is $la, 5;
        sleep(1);
        is $fire, 1;
        localalarm(0);
        $la = localalarm();
        is $la, 4;
    };

    do {
        my $la = localalarm(2);
        is $la, 4;
        sleep(2);
        is $fire, 2;
        localalarm(0);
        $la = localalarm();
        is $la, 2;
    };

    $la = localalarm(0);
    ok not $la;
};

done_testing;
