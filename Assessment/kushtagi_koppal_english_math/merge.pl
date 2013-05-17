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
    $stud{$d[7]}{data} = [ @d[0..14] ];
    $stud{$d[7]}{$d[15]} = $d[16];
    $assess{$d[15]} = 1;
}
close(INP);

# print Dumper(\%stud);

print 'DIST|BLK|CLUST|SCODE|SNAME|MOI|CLASS|STUID|CNAME|CSEX|DOB|FNAME|MNAME|ASSMNTNAME|PROGNAME|';
foreach my $a (sort keys %assess) {
    print join('|',$a), '|';
}
print "\n";

foreach my $sid (keys %stud) {
    print join('|', @{$stud{$sid}{data}}), '|';
    foreach my $a (sort keys %assess) {
        print join('|',$stud{$sid}{$a}), '|';
    }
    print "\n";
}

