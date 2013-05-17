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
    $stud{$d[4]}{data} = [ @d[0..11] ];
    $stud{$d[4]}{$d[12]} = $d[13];
    $assess{$d[12]} = 1;
}
close(INP);

# print Dumper(\%stud);

print 'BLK|CLUST|SCODE|SNAME|STUID|CNAME|GENDER|DOB|MT|CLASS|PROGNAME|ASSMNTNAME|';
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

