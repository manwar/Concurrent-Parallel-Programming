#!/usr/bin/env perl

use v5.38;
use threads;
use threads::shared;
use Thread::Semaphore;

my $reader = Thread::Semaphore->new(1);
my $writer = Thread::Semaphore->new(1);

my $rcount :shared = 0;
my $wcount :shared = 0;

sub read_worker($id) {
    $reader->down();
    {
        lock($rcount);
        $rcount++;
        $writer->down() if ($rcount == 1);
    }
    $reader->up();
    say "Reader $id reads data: $wcount";
    $reader->down();
    {
        lock($rcount);
        $rcount--;
        $writer->up() if ($rcount == 0);
    }
    $reader->up();
}

sub write_worker($id) {
    $writer->down();
    $wcount++;
    say "Writer $id writes data: $wcount";
    $writer->up();
}

my @threads = map { threads->create(\&write_worker, $_) } 1..2;
push @threads, threads->create(\&read_worker, $_) for 1..3;
$_->join() for @threads;
