# parseFileSimple.pl
# Rob Devine
# 19 June 2012
# Parses a file for a string, outputs to console

my $programName = "parseFileSimple.pl v2.3";
print "Starting $programName -------------------- \n";

my $filename = "workflows.txt";  #put input filename here
my $foundCount = 0;

open(SRC, "<$filename");
while (defined ($_ = <SRC>)) {
	my ($match) = /\"Xap\.([\w]+)\"/; #puts $1 into $match variable
	if ($match =~ /Ad/) { 
		print "\t$match\n"; 
		$foundCount++;
	}
}

print "foundCount = " . $foundCount . "\n";
print "Exiting $programName ------------------- \n";