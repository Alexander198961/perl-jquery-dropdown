#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;
my $dbh = DBI->connect("DBI:mysql:database=test;host=localhost",
                         "root", "root",
                         {'RaiseError' => 1});
#if ($action eq "view") {
print qq(Content-type: text/html\n\n);
my $query = new CGI;
my $name=$query->param('name');
my $myquery1 = "SELECT title from tutorials where title like '%$name%'";
my $sth = $dbh->prepare($myquery1);
$sth->execute();
#print "<select size=\"5\">";
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
