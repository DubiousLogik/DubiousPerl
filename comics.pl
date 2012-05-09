#!/usr/bin/perl -w
# comics.pl
# robbie devine
# 05 Feb 2005
# builds html page with pointers to daily comic images

use strict;
use LWP 5.64;

my $browser = LWP::UserAgent->new;

# constants
my $debug = 0;	# 0 = none, 1 = some, 2 = huge
my $width1 = "50%";    # left hand column
my $width2 = "50%";    # right hand column
my $temp = "C:\\temp\\temp.html";
my $comics = "C:\\temp\\comics.html";

# comic locations
my $adamUrl = "http://www.ucomics.com/adamathome/";
my $adamImg = "http://images.ucomics.com/comics/ad/2005/ad[\\d]*";

my $arloUrl = 'http://www.comics.com/comics/arlonjanis/';
my $arloImg = '/comics/arlonjanis/archive/images/arlonjanis[\\d]+';

my $baldoUrl = 'http://www.ucomics.com/baldo/';
my $baldoImg = 'http://images.ucomics.com/comics/ba/2005/ba[\\d]*';

my $boondocksUrl = 'http://www.ucomics.com/boondocks/';
my $boondocksImg = 'http://images.ucomics.com/comics/bo/2005/bo[\\d]*';

my $catsWithHandsUrl = 'http://www.uclick.com/client/smc/tmcat/';
my $catsWithHandsImg = 'http://images.ucomics.com/comics/tmcat/2005/tmcat[\\d]*';

my $dilbertUrl = 'http://www.dilbert.com/';
my $dilbertImg = '/comics/dilbert/archive/images/dilbert[\\d]*';
#my $dilbertUrl = 'http://members.comics.com/members/common/affiliateArchive.do?site=sj&comic=dilbert';
#my $dilbertImg = 'http://www.comics.com//comics/dilbert/archive/images/dilbert[\\d]*.gif';

my $duplexUrl = 'http://www.uclick.com/client/smc/dp/';
my $duplexImg = 'http://images.ucomics.com/comics/dp/2005/dp[\\d]*';

my $forBetterOrWorseUrl = 'http://www.uclick.com/client/smc/fb/';
my $forBetterOrWorseImg = 'http://images.ucomics.com/comics/fb/2005/fb[\\d]*';

my $foxtrotUrl = 'http://www.uclick.com/client/smc/ft/';
my $foxtrotImg = 'http://images.ucomics.com/comics/ft/2005/ft[\\d]*';

my $frankAndEarnestUrl = 'http://www.comics.com/comics/franknernest/index.html';
my $frankAndEarnestImg = '/comics/franknernest/archive/images/franknernest[\\d]*';

my $frazzUrl = 'http://www.comics.com/comics/frazz/';
my $frazzImg = '/comics/frazz/archive/images/frazz[\\d]*';

my $getFuzzyUrl = 'http://www.comics.com/comics/getfuzzy/';
my $getFuzzyImg = '/comics/getfuzzy/archive/images/getfuzzy[\\d]*';

my $goFishUrl = 'http://members.comics.com/members/common/affiliateArchive.do?site=sj&comic=gofish';
my $goFishImg = '/comics/gofish/archive/images/gofish[\\d]*';

my $jumpStartUrl = 'http://www.comics.com/comics/jumpstart/index.html';
my $jumpStartImg = '/comics/jumpstart/archive/images/jumpstart[\\d]*';

my $luannUrl = 'http://www.comics.com/comics/luann/';
my $luannImg = '/comics/luann/archive/images/luann[\\d]*'; 

my $montyUrl = 'http://www.comics.com/comics/monty/';
my $montyImg = '/comics/monty/archive/images/monty[\\d]*';

my $nonSequiturUrl = 'http://www.uclick.com/client/smc/nq/';
my $nonSequiturImg = 'http://images.ucomics.com/comics/nq/2005/nq[\\d]*';

my $peanutsUrl = 'http://www.comics.com/comics/peanuts/';
my $peanutsImg = '/comics/peanuts/archive/images/peanuts[\\d]*';

my $roseIsRoseUrl = 'http://www.comics.com/comics/roseisrose/';
my $roseIsRoseImg = '/comics/roseisrose/archive/images/roseisrose[\\d]*';

my $picklesUrl = 'http://www.unitedmedia.com/wash/pickles/index.html';
my $picklesImg = '/wash/pickles/archive/images/pickles[\\d]*';

my $shermansLagoonUrl = 'http://cgibin.rcn.com/fillmore.dnai/cgi-bin/sviewer.pl';
my $shermansLagoonImg = 'dailies/SL\\d\\d\.\\d\\d\.\\d\\d';	#'dailies/[\\w]*';	
# http://www.slagoon.com/dailies/SL05.02.09.gif 'dailies/SL05[\\S]*';

my $zackHillUrl = 'http://www.comics.com/creators/zack/index.html';
my $zackHillImg = '/creators/zack/archive/images/zack[\\d]+';

#----------------------- HTML Print section -----------------------------------
open(TMP, ">$temp");
open(TRG, ">$comics");

print TRG "<html>\n";
print TRG "<body>\n";

print TRG "<h2>Karen's Big Fat Comics Page</h2>";

print TRG "<table border=\"1\">\n";

print TRG "<tr>\n";
	print TRG "<td valign=\"top\" width=\"$width1\">\n <img src=\"" . getImage($adamUrl,$adamImg) 				. "\"></td>";
	print TRG "<td valign=\"top\" width=\"$width2\">\n <img src=\"http://www.comics.com/" . getImage($arloUrl,$arloImg)	. "\"></td>";
print TRG "</tr>\n";
print "10% done\n";

print TRG "<tr>\n";
	print TRG "<td valign=\"top\" width=\"$width1\">\n <img src=\"" . getImage($baldoUrl,$baldoImg)		. "\"></td>";
	print TRG "<td valign=\"top\" width=\"$width2\">\n <img src=\"" . getImage($boondocksUrl,$boondocksImg) . "\"></td>";
print TRG "</tr>\n";
print "20% done\n";

print TRG "<tr>\n";
	print TRG "<td valign=\"top\" width=\"$width1\">\n <img src=\"" . getImage($catsWithHandsUrl,$catsWithHandsImg)			. "\"></td>";
	print TRG "<td valign=\"top\" width=\"$width2\">\n <img src=\"http://www.dilbert.com" . getImage($dilbertUrl,$dilbertImg) 	. "\"></td>";
print TRG "</tr>\n";
print "30% done\n";

print TRG "<tr>\n";
	print TRG "<td valign=\"top\" width=\"$width1\">\n <img src=\"" . getImage($duplexUrl,$duplexImg)			. "\"></td>";
	print TRG "<td valign=\"top\" width=\"$width2\">\n <img src=\"" . getImage($forBetterOrWorseUrl,$forBetterOrWorseImg) 	. "\"></td>";
print TRG "</tr>\n";
print "40% done\n";

print TRG "<tr>\n";
	print TRG "<td valign=\"top\" width=\"$width1\">\n <img src=\"" . getImage($foxtrotUrl,$foxtrotImg)						. "\"></td>";
	print TRG "<td valign=\"top\" width=\"$width2\">\n <img src=\"http://www.comics.com" . getImage($frankAndEarnestUrl,$frankAndEarnestImg) 	. "\"></td>";
print TRG "</tr>\n";
print "50% done\n";

print TRG "<tr>\n";
	print TRG "<td valign=\"top\" width=\"$width1\">\n <img src=\"http://www.comics.com/" . getImage($frazzUrl,$frazzImg)					. "\"></td>";
	print TRG "<td valign=\"top\" width=\"$width2\">\n <img src=\"http://www.comics.com/" . getImage($getFuzzyUrl,$getFuzzyImg) 	. "\"></td>";
print TRG "</tr>\n";
print "60% done\n";

print TRG "<tr>\n";
	print TRG "<td valign=\"top\" width=\"$width1\">\n <img src=\"http://www.comics.com/" . getImage($goFishUrl,$goFishImg)				. "\"></td>";
	print TRG "<td valign=\"top\" width=\"$width2\">\n <img src=\"http://www.comics.com/" . getImage($jumpStartUrl,$jumpStartImg) 	. "\"></td>";
print TRG "</tr>\n";
print "70% done\n";

print TRG "<tr>\n";
	print TRG "<td valign=\"top\" width=\"$width1\">\n <img src=\"http://www.comics.com" . getImage($luannUrl,$luannImg)	. "\"></td>";
	print TRG "<td valign=\"top\" width=\"$width2\">\n <img src=\"http://www.comics.com" . getImage($montyUrl,$montyImg) 	. "\"></td>";
print TRG "</tr>\n";
print "80% done\n";

print TRG "<tr>\n";
	print TRG "<td valign=\"top\" width=\"$width1\">\n <img src=\"" . getImage($nonSequiturUrl,$nonSequiturImg)			. "\"></td>";
	print TRG "<td valign=\"top\" width=\"$width2\">\n <img src=\"http://www.comics.com/" . getImage($peanutsUrl,$peanutsImg) 	. "\"></td>";
print TRG "</tr>\n";
print "90% done\n";

print TRG "<tr>\n";
	print TRG "<td valign=\"top\" width=\"$width1\">\n <img src=\"http://www.comics.com/" . getImage($roseIsRoseUrl,$roseIsRoseImg)	. "\"></td>";
	print TRG "<td valign=\"top\" width=\"$width2\">\n <img src=\"http://www.slagoon.com/" . getImage($shermansLagoonUrl,$shermansLagoonImg) 		. "\"></td>";
print TRG "</tr>\n";
print "95% done\n";

print TRG "<tr>\n";
	print TRG "<td valign=\"top\" width=\"$width1\">\n <img src=\"http://www.unitedmedia.com" . getImage($picklesUrl,$picklesImg)	. "\"></td>";
	print TRG "<td valign=\"top\" width=\"$width2\">\n <img src=\"http://www.comics.com" . getImage($zackHillUrl,$zackHillImg) 	. "\"></td>";
print TRG "</tr>\n";
print "100% done\n";

print TRG "</table>\n";
print TRG "</body>\n";
print TRG "</html>\n";

close(TRG);
close(TMP);
#close(SRC);

#----------------------- Subroutines -----------------------------------

sub getImage {

	my $url = $_[0];
	my $imgGif = $_[1] . ".gif";
	my $imgJpg = $_[1] . ".jpg";
	my $searchText = "";
	
	if($debug) { print "\tAttempting $imgGif \n\t\tand $imgJpg\n"; }

	my $returnText = "\">Image not found. Click here: <a href=\"$url\">$url</a>";
	my $response = $browser->get( $url );
		die "Can't get $url -- ", $response->status_line
			unless $response->is_success;
		die "Site not found", $response->content_type
			unless $response->content_type eq 'text/html';

	$searchText = $response->content;

	if ($debug>1) { print "Searching: $searchText\n"; }
	if ($searchText =~ m!($imgGif)!i) {
		$returnText = $1; 
		if ($debug) { print print "found $1\n"; }
	}
	if ($searchText =~ m!($imgJpg)!i) {
		$returnText = $1; 
		if ($debug) { print print "found $1\n"; }
	}

	return $returnText;
}

#sub getImage {
#
#	my $url = $_[0];
#	my $imgGif = $_[1] . ".gif";
#	my $imgJpg = $_[1] . ".jpg";
#	
#	if($debug) {
#		print "\tAttempting $imgGif \n\t\tand $imgJpg\n";
#	}
#	my $returnText = "\">Image not found. Click here: <a href=\"$url\">$url</a>";
#	my $response = $browser->get( $url );
#		die "Can't get $url -- ", $response->status_line
#			unless $response->is_success;
#		die "Site not found", $response->content_type
#			unless $response->content_type eq 'text/html';
#
#		print TMP $response->content;
#
#	open(SRC, "<$temp");
#		while (<SRC>) {
#			if ($_ =~ m!($imgGif)!i) {
#				$returnText = $1; 
#			}
#			if ($_ =~ m!($imgJpg)!i) {
#				$returnText = $1; 
#			}
#	}
#	return $returnText;
#}
