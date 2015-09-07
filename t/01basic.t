#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use FindBin qw($Bin);
require "$Bin/../bin/mlocate-split";

delete $ENV{LOCATE_PATH};

unlink $_ for glob("$Bin/homes/*/.mlocate.db");

my $output;

system( 'updatedb', '-l0', "--output=$Bin/all.db",
    "--database-root=$Bin/homes" );

main( "--database=$Bin/all.db", "$Bin/homes/dash", "$Bin/homes/sparkle" );

$output = qx(locate --database=$Bin/homes/dash/.mlocate.db dash);
is($output,<<EOF, "Check if dashes files are split");
$Bin/homes/dash
$Bin/homes/dash/file01
EOF

$output = qx(locate --database=$Bin/homes/sparkle/.mlocate.db sparkle);
is($output,<<EOF, "Check if sparkles files are split");
$Bin/homes/sparkle
$Bin/homes/sparkle/file01
EOF

done_testing();
