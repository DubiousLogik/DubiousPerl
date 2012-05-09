#--------------------------------------------------------------------
#  parseOutput.pl
#  Script to parse web crawl results
#
#  Author:       robbie devine 
#--------------------------------------------------------------------

use encoding 'utf8';

$i = 0; # hits counter
$j = 0; # line counter
$line = "";
$debugLimit = 10000000;  #limit rows processed for debugging

my $source = "C:\\Users\\Stage 2.1\\output more urls.txt";
my $target = "C:\\Users\\Stage 2.1\\Filtered Output more Url sample.txt";

$t0 = time();
print "\nProcessing...\n";

open(TRG, ">$target");
open(SRC, "$source");

while (defined ($line = <SRC>) && ($j < $debugLimit)) {

	$FullUrl = $TopLevelDomain = $MetaDescription = $Keywords = $Title = "";
	$LastUrl = $kwFound = $metaFound = $titleFound = 0;

	chomp $line;
	$j++; 
	@words = split /\|/,$line;
	#print "$line\n";
	for ($n=0; $n<scalar(@words); $n++) {
		#print "@words[$n]\n";
		if (@words[$n] =~ m/^http[s]?:\/\//i) {
			$LastUrl++;
		}
		if (@words[$n] =~ m/<[\s]*meta[\s]*name[\s]*[=][\s]*[\"|\']description[\"|\'][\s]*content[\s]*[=][\s]*[\"|\'](.*)[\"|\']/i) {
			if ($1 !~ m/\?{3,}/) {
				$MetaDescription = $1;
				$metaFound = 1;
			}
		}
		if (@words[$n] =~ m/<[\s]*meta[\s]*name[\s]*[=][\s]*[\"|\']keywords[\"|\'][\s]*content[\s]*[=][\s]*[\"|\'](.*)[\"|\']/i) {
			if ($1 !~ m/\?{3,}/) {
				$Keywords = $1;
				$kwFound = 1;
			}
		}
		if (@words[$n] =~ m/<[\s]*title[\s]*>(.*)</i) {
			if ($1 !~ m/\?{3,}/) {
				$Title = $1;
				$titleFound = 1;
			}
		}
	}
	$FullUrl = @words[$LastUrl-1];
	#if ($kwFound || $metaFound || $titleFound) { $i++; }	
	if ($metaFound || $titleFound) { $i++; }	
	
	print TRG "$FullUrl\t";
	print TRG "$Title\t";
	print TRG "$MetaDescription\t";
	print TRG "$Keywords\n";
}

close(SRC);
close(TRG);

$t1 = time();  
$r1 = ($t1 - $t0)/60;

print "Runtime = $r1 minutes\n";
print "Total Rows: $j\nTotal Hits: $i\n";
print "\nEnding Run...";


#	if  ( $line =~ m/(([\w-]*)(\.))?([\w-]*)(\.)(com|net|org)/ ) {
#		$i++;
#		if (length($2) > 0) { print TRG "$2$3$4$5$6\n"; }
#		if (length($4) > 0) { print TRG "$4$5$6\n"; }
#	} 
