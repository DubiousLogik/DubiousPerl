#--------------------------------------------------------------------
#  ParseFileByLine.pl
#  Script to get the first N rows of a very large file for easy analysis
#
#  Author:       robbie devine
#  Keywords:     string token array 
#--------------------------------------------------------------------

use encoding 'utf8';

$line = "";
$rowLimit = 1000;  #limit rows processed for debugging
#set column numbers of interest
$domainColumn = 4;
$revenueColumn = 6;
$descriptionColumn = 7;
$bizNameColumn = 8;

my $source = "C:\\Users\\Public\\Documents\\Gadfly Data\\DBExport.txt";
my $target = "C:\\Users\\Public\\Documents\\Gadfly Data\\DandBurls.txt";

$t0 = time();
print "\nProcessing...\n";

open(TRG, ">$target");
open(SRC, "$source");

while (defined ($line = <SRC>) && ($j < $rowLimit)) {
	chomp $line;
	@words = split /\t/,$line;
	if (length(@words[$domainColumn]) >0) {
		print TRG "@words[$domainColumn]\t";
	}
	if (@words[$revenueColumn]>0) {
		print TRG "@words[$revenueColumn]\t";
	} else {
		print TRG "--\t";
	}
	if (length(@words[$descriptionColumn])>0) {
		print TRG "@words[$descriptionColumn]\t";
	} else {
		print TRG "--\t";
	}	
	if (length(@words[$bizNameColumn])>0) {
		print TRG "@words[$bizNameColumn]\t";
	} else {
		print TRG "--\t";
	}	
	$j++;
	print TRG "\n";
}

close(SRC);
close(TRG);

$t1 = time();  
$r1 = ($t1 - $t0)/60;

print "Runtime = $r1 minutes\n";
print "Total Rows: $rowLimit\n";
print "\nEnding Run...";

#	print "0 : @words[0]\n";
#	print "1 : @words[1]\n";
#	print "2 : @words[2]\n";
#	print "3 : @words[3]\n";
#	print "4 : @words[4]\n";
#	print "5 : @words[5]\n";
#	print "6 : @words[6]\n";
#	print "7 : @words[7]\n";
#	print "8 : @words[8]\n";
#	print "9 : @words[9]\n";
#	print "10 : @words[10]\n";
#	print "11 : @words[11]\n";