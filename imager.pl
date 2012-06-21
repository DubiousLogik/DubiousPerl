# imager.pl
# author: robbie devine
# purpose: reads pictures from a directory and
# creates resized (smaller) copies for web

use Image::Magick;
my $program = "imager.pl v2.4";
print "Starting $program -------------------------\n\n";

my $trgWidth;
if ( ($ARGV[0] == "") || ($ARGV[0] =~ m/\D/) ) {
	print "Usage:  \">imager.pl N\" where N is the target width in pixels\n";
	die "\n\n[perl code]: I can't go on like this, I need an integer, not [$ARGV[0]]\n\n";
} else {
	$trgWidth = $ARGV[0];
}

my $srcDir = "C:\\Users\\rdevine\\Desktop\\temp\\";
my $trgDir = "C:\\Users\\rdevine\\Desktop\\temp\\small\\";
my $imgCount = 0;
my $scaleRatio = 1.0;

while(my $srcImg = glob($srcDir."*.jpg")) {

	$imgCount++;
	
	$image=Image::Magick->new();
	$x=$image->ReadImage($srcImg);
	warn "$x" if "$x";

	my $fullPathName = $srcImg;
	my @words = split /\\/,$fullPathName;
	my $fileName = @words[$#words];
	
	#$image->Set(type=>'grayscale');
	#$image->Scale('50%');  #force a fixed scale ratio
	#$image->Scale(width=>'100');  #force a width, note - does not maintain aspect ratio

	my $srcWidth = $image->Get('width');
	if ($srcWidth > $trgWidth) { 
		$scaleRatio = $trgWidth/$srcWidth;
	} else {
		$scaleRatio = 1.0;
	}
	$image->Scale($scaleRatio*$srcWidth);
	
	$x = $image->Write($trgDir.$fileName);
	warn "$x" if "$x";

	undef $image;
	print "processed image $imgCount\tScaleRatio $scaleRatio\tFileName \"$fileName\"\n";
}

print "\nProcessed $imgCount images\n";
print "\nExiting $program -------------------------\n";
