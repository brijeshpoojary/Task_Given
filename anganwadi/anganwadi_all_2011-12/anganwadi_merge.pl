#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my $file = $ARGV[0] || 'q.lst';

open(INP, $file) || die "Cannot open $file: $!";

my (%stud, %assess);
while (<INP>) {
    chomp;
    my @d = split(/\|/);
    $stud{$d[6]}{data} = [ @d[0..12] ];
    $stud{$d[6]}{$d[13]} = $d[14];
    $assess{$d[13]} = 1;
}
close(INP);  

# print Dumper(\%stud);

print 'DIST|PROJECT|CIRCLE|SCODE|SNAME|STYPE|STUID|CNAME|CSEX|DOB|CLANG|PROGNAME|ASSMNTNAME|';
foreach my $ass (sort { $a <=> $b } keys %assess) {
    print join('|', $ass),'|';
}
print "\n";

foreach my $sid (keys %stud) {
    print join('|', @{$stud{$sid}{data}}), '|';
    foreach my $ass (sort { $a <=> $b } keys %assess) {
      print join('|', $stud{$sid}{$ass}), '|';
    }
    print "\n";
}

