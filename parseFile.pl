# parseFile.pl
# Robbie Devine
# 14 Jun 2012
# Parses a file in search of 1 param per row and puts that into an output file

my $programName = "parseFile.pl v2.2";
print "Starting $programName -------------------- \n";

my $filename = "someFile.txt";  #put input filename here
my $debugLimit = 10;		#for speedy iterations while debugging
my $lineCount = 0;		#total lines in file counter
my $outFile = "ZZ".$filename;	#output destination

print "outputting to : " . $outFile . "\n";

open(TEMP, ">$outFile.txt");
open(SRC, "<$filename");
while (defined ($_ = <SRC>) && ($lineCount < $debugLimit)) {

	my ($match) = /\"Machine\":\"([\w]+)\"/; #puts $1 into $match variable
	print $match . "\n";		#print to console
	#print TEMP $match . "\n";	#print to output file
	$lineCount++;
}

close(SRC);
close(TEMP);
print "lineCount = " . $lineCount . "\n";

print "Exiting $programName ------------------- \n";