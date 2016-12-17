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
my @inserted_tables=( "table1", "table3" ) ;

my %first_table_object=(
	column_names => [ "FIELD1" , "FIELD2" ],
	table_name =>  [ "table1" ]
);


my %second_table_object=(
	column_names => [ "BETA" , "PAST" ],
	table_name =>  [ "table3" ]
);
print qq(Content-type: text/html\n\n);
my $html = <<EOT;
EOT
;
print $html;
eval
{
	$dbh = DBI->connect("DBI:$db_name",
                         $user, $password,
                         {'RaiseError' => 1 , ShowErrorStatement => 1} );
};
if($@)
{
	print $@;
	print $fh $@;
	die("couldn't connect $@");
}

my $query = new CGI;
my $value1= $query->param('textbox');
my $value2= $query->param('dropDownvalue');
my $index=$query->param('index');
my $sth;
eval
{


#	 my %current_hash_obj;
	 if ($index == 0 )
         {

	  # we may change to insert into table_name(column1,column2)  values(?,?)
         $sth=$dbh->prepare("insert into $first_table_object{table_name}[0] ($first_table_object{column_names}[0] , $first_table_object{column_names}[1] )  values(  ?, ? )");
         }
         else
         {
	
	  # we may change to insert into table_name(column1,column2)  values(?,?)
         $sth=$dbh->prepare("insert into $second_table_object{table_name}[0] ($second_table_object{column_names}[0] , $second_table_object{column_names}[1] )  values(  ?, ? )");
         }

	 if(defined($sth))
	 {
	 $sth->execute($value1,$value2);
         }
	 else
	 {
		 die("Sth not defined");
	 }
#	$dbh->do("insert into $inserted_table values(  $value1, $value2 )");
};
if($@)
{
          print $@;
	  print $fh $@;
	  die("ERROR $@");
}
print "Succesfuly inserted";
close $fh;
