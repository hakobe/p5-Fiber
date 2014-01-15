package Fiber;

use strict;
use warnings;

use Carp qw(croak);
use Coro;

our $VERSION = '0.01';

my @yieldstack;
my @params;
my @returns;

sub new {
    my $class = shift;
    my $code  = shift;

    my $self = bless {
        coro  => undef, 
        alive => 1,
    }, $class;

    $self->{coro} = Coro->new(sub {
        $code->(@params);

        $self->{alive} = undef;
        Fiber->yield;
    });

    return $self;
}

sub yield {
    my $class = shift;
    @returns = @_;

    my $prev = pop @yieldstack;
    $prev->schedule_to;

    return wantarray ? @params : $params[0];
}

sub resume {
    my $self = shift;
    croak "dead fiber called" unless $self->{alive};

    @params = @_;

    push @yieldstack, $Coro::current;
    $self->{coro}->schedule_to;
    $self->{coro}->cancel unless $self->{alive};

    return wantarray ? @returns : $returns[0];
}

1;

__END__

=encoding utf8

=head1 NAME

Fiber - Coroutine like Ruby Fiber

=head1 SYNOPSIS

  use Fiber;

=head1 DESCRIPTION

Fiber is a coroutine implementaion like Ruby Fiber.
This module is built upon Coro.

=head1 AUTHOR

Yohei Fushii E<lt>hakobe@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
