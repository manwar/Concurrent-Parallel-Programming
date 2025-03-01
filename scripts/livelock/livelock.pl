#!/usr/bin/env perl

use v5.38;
use threads;
use threads::shared;
use Time::HiRes qw(sleep);

my $lock_a  :shared = 1;
my $lock_b  :shared = 1;
my $lock_c  :shared = 1;
my $counter :shared = 9;

sub try_lock($this) {
    {
        lock($$this);
        return 1 if $$this;
    }
    sleep(rand() / 10);
    return 0;
}

sub worker($name, $first, $second) {
    while ($counter > 0) {
        {
            lock($$first);
            if ($$first && try_lock($second)) {
                if ($counter > 0) {
                    $counter--;
                    say "$name took the turn, counter is $counter now.";
                }
            }
        }
        sleep(rand() / 10);
    }
}

my @threads;
push @threads, threads->create(\&worker, 'Thread 1', \$lock_a, \$lock_b);
push @threads, threads->create(\&worker, 'Thread 2', \$lock_b, \$lock_c);
push @threads, threads->create(\&worker, 'Thread 3', \$lock_c, \$lock_a);
$_->join foreach @threads;
