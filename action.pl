#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;
use DBD::Oracle;
my $dbh;
open( my $fh, '>>', "logfile" );


my $db_name="Oracle:xe";
my $user="SYSTEM";
my $password="ps";
my $inserted_table="table1";


print qq(Content-type: text/html\n\n);
eval
{
	$dbh = DBI->connect("DBI:$db_name",
                         $user, $password,
                         {'RaiseError' => 1 , ShowErrorStatement => 1} );
};
if($@)
{
#	print $@;
	print $fh $@;
	die("couldn't connect $@");
}

my $query = new CGI;
my $value1= $query->param('textbox');
my $value2= $query->param('dropDownvalue');
my $sth;
eval
{


         $sth=$dbh->prepare("insert into $inserted_table values(  ?, ? )");
	 $sth->execute("$value1","$value2");
#	$dbh->do("insert into $inserted_table values(  $value1, $value2 )");
};
if($@)
{
 #         print $@;
	  print $fh $@;
	  die("ERROR $@");
}
close $fh;
