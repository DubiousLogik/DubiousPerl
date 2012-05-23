# parseMB.pl
# Rob Devine
# 18 May 2012

print "Starting parseMB.pl -------------------- \n";

my $outputText = "";
my $debugLimit = 1000000000000000;
my $line = "";
my $lineCount = 0;
my @words;
my $word = "";
my $i = 0;
my $r = 0;  #RCF018 counter
my $s = 0;  #YSYNEX counter
my $c2 = 0;

my $filename = "MB1.txt";  #put input filename here
#my $filename = $ARGV[0];  #use for command line input

my $outFile = $filename;
$outFile =~ s/((\S+)\.)+(\S+)/$2_out\.$3/;  #add suffix to end of output filename

print "outputting to : " . $outFile . "\n";

open(TEMP, ">$outFile.txt");
open(SRC, "<$filename");
while (defined ($line = <SRC>) && ($lineCount < $debugLimit)) {
	#$outputText = $line;
	@words = split /\t/,$line;
	#print TEMP $outputText;
	#$i=0;
	#for (@words) { print "word " . $i . " : " . @words[$i] . "\n"; $i++; }
	#if (@words[3] == 0) { $c++; }
	$word = @words[2];
	$word =~ s/(\S*)(&bktid=YBucket%3a)(\w+)\&(\S+)\=(\S+)/$3/;
	#print "Bucket " . $word . "\n";
	if ($word =~ m/RCF018/) { 
		$r++; 
	} elsif ($word =~ m/YSYNEX/) {
		$s++;
	} elsif ($word) {
		#print "non matched : " . $word . "\n";
		$outputText .= $word . "\n";
		$c2++;
	}
	$lineCount++;
}
print TEMP $outputText;

close(SRC);
close(TEMP);
print "lineCount = " . $lineCount . "\n";
print "counter r = " . $r . "\n";
print "counter s = " . $s . "\n";
print "other = " . $c2 . "\n";
print "total r+s+other = " . ($r+$s+$c2) . "\n";

print "Exiting parseMB.pl -------------------- \n";