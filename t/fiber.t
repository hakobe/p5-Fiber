use strict;
use warnings;
use Test::More qw/no_plan/;

use Fiber;
use Perl6::Say;

my $counter = Fiber->new(sub{
    my $n = 0;
    while (1) {
        Fiber->yield($n++);
    }
});

is $counter->resume, 0;
is $counter->resume, 1;
is $counter->resume, 2;

my @result;
my $fib1;
my $fib2;
$fib1 = Fiber->new(sub{
    push @result, 'fib1-0';
    $fib2->resume;
    push @result, 'fib1-1';
    $fib2->resume;
});
$fib2 = Fiber->new(sub{
    push @result, 'fib2-0';
    Fiber->yield;
    push @result, 'fib2-1';
    Fiber->yield;
});

push @result, 'main-0';
$fib1->resume;
push @result, 'main-1';
is_deeply(\@result, [qw(main-0 fib1-0 fib2-0 fib1-1 fib2-1 main-1)]);


