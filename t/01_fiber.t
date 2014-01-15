use strict;
use warnings;
use Test::More;

use Fiber;

subtest 'single fiber runs correctly' => sub {
    my $counter = Fiber->new(sub{
        my $n = 0;
        while (1) {
            Fiber->yield($n++);
        }
    });

    is $counter->resume, 0;
    is $counter->resume, 1;
    is $counter->resume, 2;
};

subtest 'multiple fibers run correctly' => sub {
    my $counter1 = Fiber->new(sub{
        my $n = 0;
        while (1) {
            Fiber->yield($n);
            $n += 1;
        }
    });

    my $counter2 = Fiber->new(sub{
        my $n = 0;
        while (1) {
            Fiber->yield($n);
            $n += 2;
        }
    });

    is $counter1->resume, 0;
    is $counter2->resume, 0;
    is $counter1->resume, 1;
    is $counter2->resume, 2;
};

subtest 'resume can pass value' => sub {
    my $adder = Fiber->new(sub{
        my $n = 0;
        while (1) {
            my $ret = Fiber->yield($n);
            $n = $n + $ret;
        }
    });

    is $adder->resume, 0;
    is $adder->resume(1), 1;
    is $adder->resume(2), 3;
    is $adder->resume(3), 6;
};

done_testing;
