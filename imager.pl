# imager.pl
# author: robbie devine
# purpose: reads pictures from a directory and
# creates resized (smaller) copies for web

use Image::Magick;

my $program = "imager.pl v2.2";
my $srcDir = "C:\\Users\\rdevine\\Desktop\\temp\\";
my $trgDir = "C:\\Users\\rdevine\\Desktop\\temp\\small\\";
my $imgCount = 0;

print "Starting $program -------------------------\n\n";

while(my $srcImg = glob($srcDir."*.jpg")) {

	$image=Image::Magick->new();
	$x=$image->ReadImage($srcImg);
	warn "$x" if "$x";

	my $fullPathName = $srcImg;
	my @words = split /\\/,$fullPathName;
	my $fileName = @words[$#words];
	print "processing image \"$fileName\"\n";
	
	#$image->Set(type=>'grayscale');
	$image->Scale('50%');

	$x = $image->Write($trgDir.$fileName);
	warn "$x" if "$x";

	undef $image;
	$imgCount++;
}

print "\nProcessed $imgCount images\n";
print "\nExiting $program -------------------------\n";
