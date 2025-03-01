#!/usr/bin/env perl

use v5.38;
use AnyEvent;
use AnyEvent::HTTP;

my $cv = AnyEvent->condvar;

for my $url ("https://www.google.com",
             "https://www.apple.com") {
    $cv->begin;
    http_get $url, sub {
        my ($data, $headers) = @_;
        say "Received data from $url";
        $cv->end;
        return $data;
    };
}

$cv->recv;
say "All tasks done!";
