# htmlGen.pl 
# -------------------------
# Reads a directory of JPG images and creates html pages
# to navigate them as a simple photo album, alpha sorted
# Robbie Devine
# 17 May 2012
# -------------------------
# Usage:  run the script in the same folder as the images
# html files will be dropped into the same location
# -------------------------

print "\nStarting htmlGen.pl ---------------------------------------\n\n";

my $fileName = "";
my @files;
my $nextName = "";
my $lastFile = 0;

my $fileCount = 0;
while($fileName = glob("*.jpg")) {  # pass 1, get total count and list of file names
	@files[$fileCount] = $fileName;
	$fileCount++;
}

@files = sort @files;  #ensure alpha sort

my $i=0;
for(@files) {  # pass 2:  generate html files using the list
	my $name = @files[$i];
	$name =~ s/((\S+)\.)+(\S+)/$2/;  # remove extension, assume file name may contain periods
	
	print "image: " . $i . " = " . @files[$i] . " : filename = " . $name . ".html \n";
	open(OUT, ">$name.html");
	
	if ( ($i+1) < $fileCount ) {
		$nextName = @files[($i+1)];
		$nextName =~ s/((\S+)\.)+(\S+)/$2/;
	} else {
		$nextName = "";
		$lastFile = 1;
	}
 	print OUT outputHtml(@files[$i],$nextName,$lastFile) . "\n"; 	
	close(OUT);
	$i++;
}

print "Processed " . $fileCount . " files\n\n";
print "-----------------------------------------------Exiting htmlGen.pl\n";

sub outputHtml {
	my $image = $_[0];
	my $nextName = $_[1];
	my $lastFile = $_[2];
	
	my $output = "<html>\n<body>\n";
	
	$output .= "\t<img src=\"" . $image . "\" height=\"98%\">\n";
	
	if (!$lastFile) {
		$output .= "\t[<a href=\"" . $nextName . ".html\">Next</a>] &nbsp;&nbsp; \n\t[<a href=\"../index.html\">Return</a>]\n";
	} else {
		$output .= "\t[<a href=\"../index.html\">Return</a>]\n";
	}
	$output .= "</body>\n</html>\n";
	return $output;
}