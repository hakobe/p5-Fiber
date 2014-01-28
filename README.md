[![Build Status](https://travis-ci.org/hakobe/p5-Fiber.png?branch=master)](https://travis-ci.org/hakobe/p5-Fiber)
# NAME

Fiber - Coroutine like Ruby Fiber

# SYNOPSIS

    use Fiber;

    my $counter = Fiber->new(sub {
        my $n = 0;
        while (1) {
            Fiber->yield($n++);
        }
    });

    $counter->resume; # => 0
    $counter->resume; # => 1
    $counter->resume; # => 2

# DESCRIPTION

Fiber is a coroutine implementaion like Ruby Fiber.
This module is built upon Coro.

# METHODS

- new

        my $fiber = Fiber->new(sub { ... });

    Creates a new Fiber object that processes a given subrotuine reference.

- yield

        my @ret = Fiber->yield(@vals);

    Control back to the context that resume the fiber, and passing @valus to it.

- resume

        my @ret = $fiber->resume(@vals);

    Resumes the fiber from the point at which the last Fiber->yield was called, 
    or starts running it if it is the first call to resume.

# AUTHOR

Yohei Fushii <hakobe@gmail.com>

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
