#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;
my $dbh = DBI->connect("DBI:mysql:database=test;host=localhost",
                         "root", "root",
                         {'RaiseError' => 1});
print qq(Content-type: text/html\n\n);
my $myquery1 = "SELECT title from tutorials";
my $sth = $dbh->prepare($myquery1);

$sth->execute();
while (my $ref = $sth->fetchrow_hashref()) {
    print "<a href=\"#1\"> $ref->{'title'} </a>\n";
  }
