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
            Fiber->yield($n++);
        }
    });

    my $counter2 = Fiber->new(sub{
        my $n = 0;
        while (1) {
            Fiber->yield($n++);
        }
    });

    is $counter1->resume, 0;
    is $counter2->resume, 0;
    is $counter1->resume, 1;
    is $counter2->resume, 1;
};

done_testing;
