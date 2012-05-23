# ReadableMixedText.pl
# Rob Devine
# 21 May 2012

print "Starting ReadableMixedText.pl\n";

my $htmlHeader = "<html>\n<body>\n<div>\n";
my $htmlFooter = "</div>\n</body>\n</html>\n";
my $outputText = "";

#my $filename = "gears.htm";  #put input filename here
my $filename = $ARGV[0];

my $outFile = $filename;
#$outFile =~ s/((\S+)\.)+(\S+)/$2_readable\.$3/;  #add _readable to end of input filename
$outFile =~ s/((\S+)\.)+(\S+)/$2_readable\.html/;  #add _readable to end of input filename
my $fileExtension = $outFile;
$fileExtension =~ s/((\S+)\.)+(\S+)/$3/;

print $outFile . "\n";

my $lineCount = 0;

open(TEMP, ">tempReadable.txt");
open(INPUT, "<$filename");
while(<INPUT>) {
	if ($_) {
		$outputText = $_;
		$outputText =~ s/\[/\[\n/g;      #match close bracket, add newlines
		$outputText =~ s/(\|\|)/$1\n/g;  #match dbl pipes
		$outputText =~ s/(}\|)/$1\n/g;     #match pipe, add newline
		$outputText =~ s/\]/\n\]\n/g;    #match close bracket, add newlines
		$outputText =~ s/\>/\>\n/g;      #match close angle bracket, add newline
		$outputText =~ s/\&/\n\&/g;      #match close angle bracket, add newline
		#$outputText =~ s/(\s+)/$1\n/g;   #match space, add newline
		$lineCount++;
		print TEMP $outputText;
	}
}

close(INPUT);
close(TEMP);
print "lineCount1 = " . $lineCount . "\n";

$outputText = "";
$lineCount = 0;

#use temp file as input to next stage in pipeline
my $tabs = 0;
open(OUTPUT, ">$outFile");  # final output goes here
print OUTPUT $htmlHeader;
open(TEMP, "<tempReadable.txt");
while(<TEMP>) {
	if ($_) {
		if ($_ =~ m/\]|}/) { $tabs--; }  #match close bracket, decrement tabs, applies to this row
		$outputText = $_;
		$outputText = addTabs($tabs) . $outputText;
		print OUTPUT $outputText;
		$lineCount++;
		if ($_ =~ m/\[|{/) { $tabs++; }  #match open bracket, increment tabs, applies to next row		
	}
}
print OUTPUT $htmlFooter;
close(TEMP);
close(OUTPUT);

print "lineCount2 = " . $lineCount . "\n";
print "\n"."exiting ReadableMixedText.pl"."\n";

sub addTabs {
	my $count = $_[0];
	my $prepend = "";
	for ($i=0; $i<$count; $i++) { $prepend .= "\t"; }
	return $prepend;
}