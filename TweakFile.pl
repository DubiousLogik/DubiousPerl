# Reads a text file, alters some characters, and outputs the data to a new file
# Robbie Devine
# 30 April 2012
# starter template for modifying files quickly

$filename = "ga.js";

print "Starting TweakFile.pl";

open(SUMM, ">Tweaked.txt");
$outputText = "";
$rowcount = 0;


open(TEMP, "<$filename");
  while(<TEMP>) {
    $outputText = $_; 
    
    $outputText =~ s/;/;\\n/;
    
    $rowcount++; 
    print SUMM $outputText;
  }
  close(TEMP);


close(SUMM);
print "rowcount = " . $rowcount . "\n";
print "exiting Merge Files.pl";