package Alarm::Local;
use 5.008_001;
use strict;
use warnings;
use parent qw(Exporter);

our $VERSION = '0.01';

our @EXPORT = qw();
our @EXPORT_OK = qw(localalarm);
our @ALARM_STACK = (0);
our $ELAPSED_TIME=0;

sub localalarm {
    my $sec = shift;

    if (not defined $sec) {
        return $ALARM_STACK[-1] - $ELAPSED_TIME;
    }
    elsif ($sec > 0) {
        my $old_alarm = alarm($sec);
        push @ALARM_STACK, $sec;
        return $old_alarm;
    }
    elsif ($sec == 0) {
        my $current_alarm = pop @ALARM_STACK;
        my $old_alarm     = $ALARM_STACK[-1];
        my $next_alarm    = ($old_alarm - ($current_alarm + $ELAPSED_TIME));
        $ELAPSED_TIME     += $current_alarm;
        return alarm($next_alarm);
    }
    elsif ($sec < 0) {
        $ELAPSED_TIME = 0;
        @ALARM_STACK  = (0);
        return alarm(0);
    }

    die '$sec must be numecric.';
}

1;
__END__

=head1 NAME

Alarm::Local - Perl extention to do something

=head1 VERSION

This document describes Alarm::Local version 0.01.

=head1 SYNOPSIS

    use Alarm::Local;

=head1 DESCRIPTION

# TODO

=head1 INTERFACE

=head2 Functions

=head3 C<< hello() >>

# TODO

=head1 DEPENDENCIES

Perl 5.8.1 or later.

=head1 BUGS

All complex software has bugs lurking in it, and this module is no
exception. If you find a bug please either email me, or add the bug
to cpan-RT.

=head1 SEE ALSO

L<perl>

=head1 AUTHOR

Atsushi Kobayashi E<lt>nekokak@gmail.comE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2012, Atsushi Kobayashi. All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
