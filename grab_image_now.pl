#!/usr/bin/perl -w
# grab_image_now.pl
# robbie devine
# 09 Oct 2004
# grabs an image using lwp, saves to file without parsing it

use strict;
use LWP 5.64;
use LWP::UserAgent;
use Time::HiRes qw(time);

#constants
my $url = 'http://www.fs.fed.us/gpnf/volcanocams/msh/images/mshvolcanocam.jpg';
my $fileName = "C:\\temp\\volcano\\volcano";
my $ext = 'jpg';

my $t0 = time();
my $ua = LWP::UserAgent->new;
my $req = HTTP::Request->new(GET => $url);
my $res = $ua->request($req,"$fileName\_$t0\.$ext");  

