#!/usr/bin/perl
# lwpQuick.pl
# rdevine
# 21 Jun 2012

use LWP; 
print "Starting  ----------------------------------------------\n";
my $url = @ARGV[0];  #required

if (@ARGV[0]) {
	my $browser = LWP::UserAgent->new;
	my $response = $browser->get( $url );
		die "Can't get $url -- ", $response->status_line
			unless $response->is_success;
	my $text = $response->content;
	print $text;	
} else {
	print "Please enter a URL\n";
}
print "\n---------------------------------------------- Exiting \n";
