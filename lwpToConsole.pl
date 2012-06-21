#!/usr/bin/perl
# lwpQuick.pl
# rdevine
# 21 Jun 2012

use LWP; 
print "Starting  ----------------------------------------------\n";
my $url = @ARGV[0];  #required
my $linesToPrint = @ARGV[1];  #optional, default to 10k below
my $counter = 0;

if (!($linesToPrint > 0)) { $linesToPrint = 10000; }

if (@ARGV[0]) {
	my $browser = LWP::UserAgent->new;
	my $response = $browser->get( $url );
		die "Can't get $url -- ", $response->status_line
			unless $response->is_success;
	my $text = $response->content;
	my @lines = split /\n/,$text;
	if ($#lines == 0) {
		@lines = split /\>|\}/,$text; #if no newlines, split on tags
	}
	while (($counter < $linesToPrint) && ($counter <= $#lines)) {
		print @lines[$counter] . "\n";
		$counter++;
	}
	
} else {
	print "Please enter a URL\n";
}

print "\n---------------------------------------------- Exiting \n";
