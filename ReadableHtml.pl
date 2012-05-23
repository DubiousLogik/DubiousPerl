# ReadableHtml.pl
# take mixed format text and create an html page with 
# some highlighting of param names and values
# Rob Devine
# 21 May 2012

my $version = 5.11;

print "\nStarting ReadableHtml.pl $version\n";
my $filename = $ARGV[0];  #get input filename here
my $outFile = $filename;
$outFile =~ s/((\S+)\.)+(\S+)/$2_readable\.html/;  #add _readable to end of input filename

my $br = "<br>\n";
my $blueL = "<span style='color:blue'>";  #blue Left side span tag
my $redL = "<span style='color:#C00000'>"; #red Left side span tag
my $endSpan = "</span>"; 
my $gt = "&gt;";
my $lt = "&lt;";
my $outputText = "";

print $outFile . "\n";
my $lineCount = 0;

open(INPUT, "<$filename");
open(OUTPUT, ">$outFile");
print OUTPUT "<html>\n<body>Output by ReadableHtml.pl Version: $version<br>\n<div>\n";
while(<INPUT>) {
	if ($_) {
		$outputText = $_;
  		$outputText =~ s/</<</g;           #set brackets to temp value before you add other single brackets
		$outputText =~ s/>/>>/g;           #set to temp value
		$outputText =~ s/(\])/$br$1$br/;   #match close bracket, add newlines		
		$outputText =~ s/(\|\|)/$1$br/g;   #match dbl pipes
		$outputText =~ s/(\}\|)/$1$br/g;   #match bracket pipe, add newline
		$outputText =~ s/\&/$br\&/g;       #match & add newline
		$outputText =~ s/([\w\"\.\-]+)(:|=)([\w\.\- \+\(\)]*)/$blueL$1$endSpan$2$redL$3$endSpan/g; #highlighting
		$outputText =~ s/<</$lt/g;         #change temp value to html-friendly value without changing tags set above
		$outputText =~ s/>>/$gt/g;         #change temp value to html-friendly
		$lineCount++;
		print OUTPUT $outputText;
		#print $outputText . "\n";  #debugging
	}
}
print OUTPUT "</div>\n</body>\n</html>\n";
close(INPUT);
close(OUTPUT);
print "lineCount1 = " . $lineCount . "\n";
print "\n"."exiting ReadableHtml.pl"."\n";