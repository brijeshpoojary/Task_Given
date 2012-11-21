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
    $stud{$d[6]}{data} = [ @d[0..10] ];
    $stud{$d[6]}{$d[11]} = $d[12];
    $assess{$d[11]} = 1;
}
close(INP);

# print Dumper(\%stud);

print 'DIST|BLK|CLUST|SCODE|SNAME|MOI|STUID|CSEX|CLANG|CURRNAME|ENAME|';
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

