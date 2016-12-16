#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;
use DBD::Oracle;
my $dbh;
open( my $fh, '>>', "logfile" );



my @column_names =("table_name","INFO");
my @table_names=("dba_tables", "help");
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
	print $fh $@;
	die("couldn't connect $@");
}

my $query = new CGI;
my $index=$query->param('index');
my $sth;
eval
{

my $myquery1 = "SELECT $column_names[$index]  from $table_names[$index] ";
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

print "<select id=\"mySelect$index\" onchange=\"select($index)\">";
my $first_value= shift @array;
print "<option  id=\"myid1\"  value=\"$first_value\">$first_value</option>";
foreach  (@array) {
print "<option    value=\"$_\">$_</option>";

}
print "</select>";
close $fh;
