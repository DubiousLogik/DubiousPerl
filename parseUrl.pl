#--------------------------------------------------------------------
#  parseUrl.pl
#  Script to parse top level domains from a flat file
#  robbie devine
#  2009
#--------------------------------------------------------------------

# MAIN

use encoding 'utf8';

$i = 0; # hits counter
$j = 0; # line counter
$line = "";
$debugLimit = 99999999;  #limit rows processed for debugging

my $source = "C:\\Users\\Public\\Documents\\Spam_V2.wsv";
my $target = "C:\\Users\\Public\\Documents\\Spam V2 Filtered.txt";
my $target2 = "C:\\Users\\Public\\Documents\\Spam V2 Filtered2.txt";

$t0 = time();
print "\nProcessing...v1 ...\n";

open(TRG, ">$target");
open(SRC, "$source");

while (defined ($line = <SRC>) && ($j < $debugLimit)) {
	chomp $line;
	$j++; 
	@words = split /\s/,$line;
	if  (($line =~ m/(([\w-]*)(\.))?([\w-]*)(\.)(com|net|org)(\s?)(\w*?)/)) {
		$i++;
		print TRG "$4$5$6\n"; 
	} 	
}

close(SRC);
close(TRG);

print "Total Rows: $j\nTotal Hits: $i\n\n";

open(TRG, ">$target2");
open(SRC, "$target");
my $prev = "X"; 
my $this = "";

$j=$i=0;

while (defined ($line = <SRC>) ) {
	chomp $line;
	@dParts = split /\./,$line;
	$j++;
	if ( scalar(@dParts)>0 ) {
		$this = @dParts[0];
		if ( !($this =~ m/$prev/)  ) {
			$prev = $this;
			print TRG "@dParts[0].@dParts[1]\n"; 
			$i++;
		} #else 	{ print "EQUAL $this $prev " . length($this) . " " . length($prev) . "\n";}
	} #else 	{ print "failed non null for $line\n"; }
}

close(SRC);
close(TRG);

$t1 = time();  
$r1 = ($t1 - $t0)/60;

print "Runtime = $r1 minutes\n";
print "Total Rows: $j\nTotal Hits: $i\n";
print "\nEnding Run...";
