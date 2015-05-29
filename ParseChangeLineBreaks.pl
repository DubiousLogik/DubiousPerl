# --------------------------------------------------------------------------------------------
#!/usr/bin/perl

print "Starting ParseRESX.pl ----------------------------------------------\n";

# constants
my $file1 = "strings.resx";
my $outputFile = "strings.txt";
my $lineCount = 0;
my $pattern = "Alert_";

#remove line breaks, create 1 long line
open(TEMP, ">temp.txt");
open(INPUT, "<$file1");
while(<INPUT>) {
	if ($_) {
		$outputText = $_;
		$outputText =~ s/\n//g;    
		$lineCount++;
		print TEMP $outputText;
	}
}

close(INPUT);
close(TEMP);
print "lineCount1 = " . $lineCount . "\n"; # debugging

#Put line breaks on closing tags of your choice
$outputText = "";
$lineCount = 0;
open(TEMP2, ">temp2.txt");  
open(TEMP, "<temp.txt");
while(<TEMP>) {
	if ($_) {
		$outputText = $_;		
		$outputText =~ s/data\>/data\>\n/g; 
		print TEMP2 $outputText;
		$lineCount++;
	}
}

close(TEMP);
close(TEMP2);
print "lineCount2 = " . $lineCount . "\n"; #debugging

#extract rows you care about
$outputText = "";
$lineCount = 0;
open(TEMP2, "<temp2.txt");
open(OUTFILE, ">$outputFile");
while(<TEMP2>) {
	if ($_) {
		$outputText = $_;		
		if ($outputText =~ m/$pattern/) {
			print OUTFILE $outputText;  # debugging
		}
		$lineCount++;
	}	
}
close(TEMP2);
close(OUTFILE);