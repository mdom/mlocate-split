#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use Test::Output;
use FindBin qw($Bin);
require "$Bin/../bin/mlocate-split";

delete $ENV{LOCATE_PATH};

unlink $_ for glob("$Bin/homes/*/.mlocate.db");

my $output;

system( 'updatedb', '-l0', "--output=$Bin/all.db",
    "--database-root=$Bin/homes" );

main( "--database=$Bin/all.db", "$Bin/homes/dash", "$Bin/homes/sparkle" );

stdout_is {
    system("locate --database=$Bin/homes/dash/.mlocate.db dash")
}
    <<EOF, "Check if dashes files are split";
$Bin/homes/dash
$Bin/homes/dash/file01
EOF

stdout_is {
    system("locate --database=$Bin/homes/sparkle/.mlocate.db sparkle");
}
<<EOF, "Check if sparkles files are split";
$Bin/homes/sparkle
$Bin/homes/sparkle/file01
EOF

stderr_is {
	eval { main( "--database=$Bin/no.db", "$Bin/homes/dash", "$Bin/homes/sparkle" ) };
	warn "$@" if $@;
}
<<EOF, "Use not existing database";
Can't open database $Bin/no.db: No such file or directory.
EOF

done_testing();
