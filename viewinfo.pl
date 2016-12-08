#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;
use DBD::Oracle;
my $dbh;
open( my $fh, '>>', "logfile" );

my $table_name="dba_tables";
my $column_name="table_name";

my $db_name="Oracle:xe";
my $user="SYSTEM";
my $password="ps";


print qq(Content-type: text/html\n\n);

eval
{
	$dbh = DBI->connect("DBI:Oracle:xe",
                         $user, $password,
                         {'RaiseError' => 1});
};
if($@)
{
#	print $@;
	print $fh $@;
	die("couldn't connect $@");
}

my $query = new CGI;
my $name=$query->param('name');
my $sth;
eval
{

my $myquery1 = "SELECT $column_name  from $table_name ";
$sth = $dbh->prepare($myquery1);
$sth->execute();
};
if($@)
{
#	 print $@;
	print $fh $@;
  die("coldn't connect $@");  
}
my $count=0;
my @array;

while (my @rows = $sth->fetchrow_array) {
	
push(@array,$rows[0]);
$count++;  
}
my $id=0;
print "<select size=\"$count\">";
foreach  (@array) {
$id++;	
print "<option    value=\"$_\" id=\"$id\" onclick=\"select(this)\">$_</option>";

}
print "</select>"; 
close $fh;
