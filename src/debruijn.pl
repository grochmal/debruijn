#!/usr/bin/env perl

use strict;
use warnings;

sub permutate ($$) {
    my $alph  = shift;
    my $cur   = shift;
    $cur =~ s/^.//;
    my $perms = [];
    push @$perms, $cur . $_ foreach (@$alph);
    $perms;
}

#my $gviz    = shift || 'twopi';
#my $gviz    = shift || 'circo';
my $gviz    = shift || 'sfdp';
#my $gviz    = shift || 'dot';
my $asize   = shift || 2;
my $ssize   = shift || 3;
my $out     = shift || 'debruijn';
my $thumb   = shift || 'gthumb';
my @letters = ('A'..'Z');
my @alph    = @letters[0..($asize-1)];
my @curp    = $alph[0] x $ssize;
my %done    = ();
my $keys    = -1;
while ($keys < scalar keys %done) {
    $keys    = scalar keys %done;
    my @newp = ();
    foreach my $cp (@curp) {
        my $perms = permutate \@alph, $cp;
        foreach (@$perms) {
            my $mark  = "$_ -> $cp";
            $done{$mark} = 1;
            #print "$mark\n" foreach (@$perms);
        }
        push @newp, @$perms;
    }
    @curp = @newp;
}
open my $dot, '>', "$out.dot";
print $dot "digraph DB {\n";
print $dot "  node [style=filled,color=darkgreen,fillcolor=aquamarine];\n";
print $dot "  edge [splines=curved,overlap=false,color=darkgreen];\n";
foreach (keys %done) {
    print $dot "  $_\n";
    print      "$_\n";
}
print $dot "}\n";
close $dot;
my $cmd = "$gviz -T png -o $out.png $out.dot";
print "$cmd\n";
system $cmd;
$cmd = "$thumb $out.png";
print "$cmd\n";
system $cmd;

