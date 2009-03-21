use inc::Module::Install;
name 'Fiber';
all_from 'lib/Fiber.pm';

requires $_ for (qw/ /);

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
