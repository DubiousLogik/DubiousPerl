#!/usr/bin/perl
#---------------------
#  PROGRAM:  gcd.pl  
#  author:  rob devine
#  date:  26 apr 2012
#---------------------
# finds Greatest common denominator of 2 integers

use Time::HiRes 
Time::HiRes::usleep ($microseconds);
my $t1 = [Time::HiRes::gettimeofday];

print "\nStarting gcd.pl ------------------------------------------\n\n";

my $count = 0;
my $gcdCandidate = 1;
my $maxlen = 0;

my $numArgs = $#ARGV + 1;
if ($numArgs != 2) {
	print "Usage:  enter 2 integers \n";
} else {

	my $a = $ARGV[0];
	my $b = $ARGV[1];

	if ($b > $a) { $t = $a; $a = $b; $b = $t; }
	
	$maxlen = length($a);
	my $param1 = "A".$maxlen;
	$maxlen = length($b);
	my $param2 = "A".$maxlen;
	
	while ($b > 0) {
		$gcdCandidate = $b;
		$rem = $a%$b;
		#print "A: $a  B: $b  Rem: $rem \n";
		print "A: " . rightJustify(pack($param1,$a)) . " B: " . rightJustify(pack($param2,$b)) . " Rem: " . rightJustify(pack($param2, $rem)) . "\n";
		$a = $b;
		$b = $rem;
		$count++;
	}
	print "\nGCD: $gcdCandidate \n";	
}

$elapsed = Time::HiRes::tv_interval($t1, [Time::HiRes::gettimeofday]);

print "\nelapsed: $elapsed seconds \n";
print "count of steps:  $count \n";
print "------------------------------------------  exiting gcd.pl\n";

sub rightJustify {
# right justifies a number within a string, where input is digits followed by spaces, e.g. dddsssss
# does not reverse the order of individual chars; 
	my $value = $_[0];
	$value =~ s/(\d+)(\s+)/$2$1/;  #match d's and s's then swap them
	return $value;
}

#sub rightJustify {
# moves a number to the right most chars in a string
# number is already in the right order (this is not a reverse ordering of all chars)
# assumes input is of the shape [ddddsssssss] where d is a digit and s is a space for any count of d's and s's
# does not change length of input string
	
	#my $temp = $_[0];
	#my $num = "";
	#my $prepend = "";
	
	#for (my $i=0; $i<length($temp); $i++) {
	#	my $char = substr($temp,$i,1);
	#	if ($char =~ m/\d/) { $num .= $char; } 
	#	else { $prepend .= $char; }
	#}	
	#return $prepend . $num;
#}