#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;
my $dbh;
open( my $fh, '>>', "logfile" );

my $table_name="tutorials";
my $column_name="title";
# Or oracle:db_name

my $db_name="mysql:test";
#my $db_name="oracle:db_name_here";


my $user="root";

my $password="root";


print qq(Content-type: text/html\n\n);
eval
{
	 #$ENV{ORACLE_SID} = $;
	 #  $dbh = DBI->connect( "dbi:Oracle:", "", "", { ora_session_mode => ORA_SYSDBA } );
	#$dbh = DBI->connect("dbi:Oracle:$dbname", $user, $passwd);
	$dbh = DBI->connect("DBI:$db_name",
                         $user, $password,
                         {'RaiseError' => 1});
};
if($@)
{
	print $fh $@;
	die("couldn't connect $@");
}


my $query = new CGI;
my $name=$query->param('name');
my $sth;
eval
{
my $myquery1 = "SELECT $column_name  from $table_name where title like '%$name%'";
$sth = $dbh->prepare($myquery1);
$sth->execute();
};
if($@)
{
  print $fh $@;
  die("coldn't connect $@");  
}
my $count=0;
my @array;

while (my $ref = $sth->fetchrow_hashref()) {
push(@array,$ref->{'title'});
$count++;  
}
my $id=0;
print "<select size=\"$count\">";
foreach (@array) {
$id++;	
print "<option    value=\"$_\" id=\"$id\" onclick=\"select(this)\">$_</option>";

}
print "</select>"; 
close $fh;
