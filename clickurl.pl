# counts bytes of click urls vs overall page weight for common search engine pages
# Robbie Devine
# 02 May 2012

#print "Starting clickurl.pl\n"; #debugging

my $outputText = "";
my $filename = "zing1.txt";  #put input filename here
my $totalCharCount = 0;
my $urlCharCount = 0;
my $lineCount = 0;
my $urlCount = 0;
my $pattern = "r\.domain\.com"; #use for bing
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
print "File: " . $filename . "\n";
print "Total Char Count: " . $totalCharCount . "\n";
print "Total Url Count: " . $urlCount . "\n";
print "Total Url Char Count: " . $urlCharCount . "\n";
print "Url Count Weight (Url Chars / Page Chars) = " . ($urlCharCount/$totalCharCount) . "\n";
print "\n------------------------------\n";
