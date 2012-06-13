# imager.pl
# author: robbie devine
# purpose: reads pictures from a directory and
# creates resized (smaller) copies for web

use Image::Magick;

my $program = "imager.pl v2.2";
my $srcDir = "C:\\Users\\rdevine\\Desktop\\temp\\";
my $trgDir = "C:\\Users\\rdevine\\Desktop\\temp\\small\\";
my $imgCount = 0;
my $trgWidth = 900;  #target width of image, in pixels
my $scaleRatio = 1.0;

print "Starting $program -------------------------\n\n";

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

	#for this version I'm setting a default width of 900px for the blog
	#this approximates a 4x6 photo, landscape orientation; photos in portrait orientation 
	#may or may not be scaled
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
