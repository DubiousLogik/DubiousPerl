# --------------------------------------------------------------------------------------------
#!/usr/bin/perl
# lwpScraper.pl
# robbie devine
# 03 May 2012
# --------------------------------------------------------------------------------------------
# Notes:  this is written quick and dirty, data is piped thru files
# due to easy use of regex substitution and selective introduction of 
# line breaks where I want them.  This could be made more efficient by 
# using split and arrays to keep all the work in memory.  OTOH since 
# you are making web call, you'll pay ~1 sec per query anyway, the 
# extra few ms for disk I/O may be trivial overall.
# --------------------------------------------------------------------------------------------

#package EdgarBot;
#use strict;
use LWP; # 5.64;

print "Starting lwpScraper.pl ----------------------------------------------\n";

# constants
my $file1 = "scrape1.txt";
my $queryFile = "queries.txt";
my $baseUrl = "http://bing.com/search?q=";
my $query = "";

my $browser = LWP::UserAgent->new;
#Use this only if a proxy exists
#$browser->proxy(['http', 'ftp'], 'http://mv1-ce-01.placeware.com:8080/');

open(QUERIES, "<$queryFile");

while (<QUERIES>) {
	$query = $_;
	$query =~ s/\n//;  #remove line breaks
	# print "Processing query: [" . $query . "]\n"; # debugging
	open(FILE1, ">$file1");
	my $response = $browser->get( $baseUrl.$query );
		die "Can't get $url -- ", $response->status_line
			unless $response->is_success;
		die "Site not found", $response->content_type
			unless $response->content_type eq 'text/html';

		print FILE1 $response->content;
		close(FILE1);
		urlWeight($file1,$query);
}

print "\n---------------------------------------------- Exiting lwpScraper.pl\n";

sub urlWeight {

	my $filename = $_[0];
	my $query = $_[1];
	
	my $outputText = "";
	#my $filename = "bing1.txt";  #put input filename here
	my $totalCharCount = 0;  
	my $urlCharCount = 0;
	my $lineCount = 0;
	my $urlCount = 0;
	my $pattern = "r\.msn\.com"; #use for bing
	#my $pattern = "google\.com\/aclk";

	open(TEMP, ">temp.txt");
	open(INPUT, "<$filename");
	while(<INPUT>) {
		if ($_) {
			$outputText = $_;
			$outputText =~ s/\n//g;    #remove line breaks, create 1 long line
			$lineCount++;
			print TEMP $outputText;
		}
	}

	close(INPUT);
	close(TEMP);
	#print "lineCount1 = " . $lineCount . "\n"; # debugging

	$outputText = "";
	$lineCount = 0;

	#use temp file as input to next stage in pipeline
	my $tabs = 0;
	open(TEMP2, ">temp2.txt");  
	open(TEMP, "<temp.txt");
	while(<TEMP>) {
		if ($_) {
			$outputText = $_;		
			$totalCharCount = length($outputText);
			$outputText =~ s/\>/\>\n/g; #add line breaks after closing tags, ensure 1 element per line
			print TEMP2 $outputText;
			$lineCount++;
		}
	}

	close(TEMP);
	close(TEMP2);
	#print "lineCount2 = " . $lineCount . "\n"; #debugging

	$outputText = "";
	$lineCount = 0;

	open(TEMP2, "<temp2.txt");
	while(<TEMP2>) {
		#look for Urls here
		if ($_) {
			$outputText = $_;		
			if ($outputText =~ m/$pattern/) {
				$outputText =~ s/\<a href\=\"(\S+)\" h=(\S+)\"\>/$1/; #remove extra stuff around the url itself
				#print $outputText;  # debugging
				$urlCharCount += length($outputText);
				$urlCount++;
			}
			$lineCount++;
		}	
	}
	close(TEMP2);

	#print "lineCount3 = " . $lineCount . "\n"; # debugging
	print "\n------------------------------\n";
	print "Query: [" . $query . "]\n";
	print "Total Char Count: " . $totalCharCount . "\n";
	print "Total Url Count: " . $urlCount . "\n";
	print "Total Url Char Count: " . $urlCharCount . "\n";
	if ($totalCharCount>0) {
		print "Url Count Weight (Url Chars / Page Chars) = " . ($urlCharCount/$totalCharCount) . "\n";
	}
	#print "\n------------------------------\n";


}