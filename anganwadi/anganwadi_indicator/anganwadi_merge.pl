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
    $stud{$d[3]}{data} = [ @d[0..6] ];
    $stud{$d[3]}{$d[7]} = $d[9];
    $assess{$d[7]} = $d[8];
}
close(INP);  

# print Dumper(\%stud);

print 'DIST|PROJ|CIRCLE|SCODE|SNAME|START_DATE|END_DATE|';
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

