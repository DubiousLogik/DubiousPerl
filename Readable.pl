# Reads a text file with packed code (no line breaks)
# and adds line breaks and tabs to make more readable
# Assumes input file and program are all in same (local) directory
# Quick and dirty, no error checking to speak of
# Robbie Devine
# 01 May 2012
 
print "Starting Readable.pl\n";

my $outputText = "";

#my $filename = "gears.htm";  #put input filename here
my $filename = $ARGV[0];

my $outFile = $filename;
$outFile =~ s/((\S+)\.)+(\S+)/$2_readable\.$3/;  #add _readable to end of input filename
my $fileExtension = $outFile;
$fileExtension =~ s/((\S+)\.)+(\S+)/$3/;
my $hasTags = 0;
if ($fileExtension=="xml" || $fileExtension=="html" || $fileExtension=="htm") { $hasTags=1; }

print $outFile . "\n";

my $lineCount = 0;

open(TEMP, ">tempReadable.txt");
open(INPUT, "<$filename");
while(<INPUT>) {
	if ($_) {
		$outputText = $_;
		$outputText =~ s/(for[\s]*\()/\n$1/g;    #match 'for' declaration, add newline
		$outputText =~ s/{/{\n/g;    #match open bracket, add newline
		$outputText =~ s/}/\n}\n/g;  #match close bracket, add newlines
		if ($hasTags) { $outputText =~ s/\>/\>\n/g; } #match close angle bracket, add newline
		$lineCount++;
		print TEMP $outputText;
	}
}

close(INPUT);
close(TEMP);
print "lineCount1 = " . $lineCount . "\n";

$outputText = "";
$lineCount = 0;

open(TEMP, ">tempReadable2.txt");
open(INPUT, "<tempReadable.txt");
while(<INPUT>) {
	if ($_) {
		$outputText = $_;
		if ($outputText !~ m/for[\s]*\(/) {
			$outputText =~ s/;/;\n/g;    #match semicolon, add newline for all but 'for' declarations
		} else {
			#print "Matched for, outputText = " . $outputText . "\n"; #debugging
			my $temp1 = $outputText;
			my $temp2 = $outputText;
			$temp1 =~ s/(for[\s]*\((.*(\(.*(\(.*\))*.*\))*.*)*\))(.*)/$1\n/; #put newline after for
			$temp2 =~ s/(for[\s]*\((.*(\(.*(\(.*\))*.*\))*.*)*\))(.*)/$5/; #put remainder in temp2
			$temp2 =~ s/;/;\n/g; #put newlines after semicolons in remainder
			$outputText = $temp1 . $temp2;
			#print "After version, outputText = " . $outputText . "\n"; #debugging
		}
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
open(TEMP, "<tempReadable2.txt");
while(<TEMP>) {
	if ($_) {
		if ($_ =~ m/}/) { $tabs--; }  #match close bracket, decrement tabs, applies to this row
		$outputText = $_;
		$outputText = addTabs($tabs) . $outputText;
		print OUTPUT $outputText;
		$lineCount++;
		if ($_ =~ m/{/) { $tabs++; }  #match open bracket, increment tabs, applies to next row		
	}
}

close(TEMP);
close(OUTPUT);

print "lineCount2 = " . $lineCount . "\n";
print "\n"."exiting Readable.pl"."\n";

sub addTabs {
	my $count = $_[0];
	my $prepend = "";
	for ($i=0; $i<$count; $i++) { $prepend .= "\t"; }
	return $prepend;
}