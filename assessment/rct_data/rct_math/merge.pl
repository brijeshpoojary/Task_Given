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
    $stud{$d[5]}{data} = [ @d[0..15] ];
    $stud{$d[5]}{$d[16]} = $d[17];
    $assess{$d[16]} = 1;
}
close(INP);

# print Dumper(\%stud);

print 'DIST|BLK|CLUST|SCODE|SNAME|STUID|CNAME|GENDER|DOB|MOTHER|FATHER|MT|CLASS|PROGNAME|STARTDATE|ASSMNTNAME|';
foreach my $a (sort keys %assess) {
    print join('|',$a), '|';
}
print "\n";

foreach my $sid (sort keys %stud) {
    print join('|', @{$stud{$sid}{data}}), '|';
    foreach my $a (sort keys %assess) {
        print join('|',$stud{$sid}{$a}), '|';
    }
    print "\n";
}

