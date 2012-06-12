# passwordStrength.pl
# validate if a given string is a strong enough password
# 11 June 2012
# robbie devine

my $programName = "passwordStrength.pl v2.3";
print "\nStarting $programName --------------------------------------------\n\n";

my $password = $ARGV[0];  #input param
my $ok = 1;

print "Processing password candidate $password\n\n";

if (length($password) < 8 ) { print "password must be at least 8 characters\n"; $ok=0; }
if ($password !~ m/[A-Z]/)  { print "password must contain upper case letters\n"; $ok=0; }
if ($password !~ m/[a-z]/)  { print "password must contain lower case letters\n"; $ok=0; }
if ($password !~ m/[0-9]/)  { print "password must contain numbers\n"; $ok=0; }
if ($password !~ m/[!@#\$%^&*()_\-\[\]\'\"]/) { print "password must contain special characters\n"; $ok=0; }
if ($password =~ /(\S)(?=\1{2})/) { print "password cannot contain 3 or more identical characters in a row\n"; $ok=0; }
if ($password =~ /password/i) { print "password cannot contain the string 'password'"; $ok=0; }

if ($ok) { print "\nPassword is ok\n"; }
else { print "\nErrors found\n"; }

print "\n-------------------------------------------- exiting $programName.pl\n";