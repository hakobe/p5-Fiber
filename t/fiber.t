use strict;
use warnings;
use Test::More;

use Fiber;

subtest 'yield and resume' => sub {
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

done_testing;
