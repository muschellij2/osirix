#!/usr/bin/perl
use strict;
use warnings;

die "$0: Must be run from Xcode" unless $ENV{"BUILT_PRODUCTS_DIR"};

my $FH;
my $output;

# SHA hash :

open $FH, "xcrun git rev-parse HEAD|" or die;
$output = <$FH>;
close($FH);

chomp( $output );
my $GitHash = $output;

# clean state :

$output = `xcrun git status`;

my $GitState;
if ( index( $output, "nothing to commit (working directory clean)" ) != -1 ) {
    $GitState = "clean";
} else {
    $GitState = "dirty";
}

print "GitHash : $GitHash\n";
print "GitState : $GitState";

# Update Info.plist in build product. Use defaults command

#my $INFO = "$ENV{BUILT_PRODUCTS_DIR}/$ENV{WRAPPER_NAME}/Info"; #iOS
my $INFO = "$ENV{BUILT_PRODUCTS_DIR}/$ENV{WRAPPER_NAME}/Contents/Info"; #OSX

my @defaults = ( 'defaults', 'write', $INFO, 'GitHash', "$GitHash" );
system( @defaults );

@defaults = ( 'defaults', 'write', $INFO, 'GitState', "$GitState" );
system( @defaults );
