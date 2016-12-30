#!/usr/bin/perl
use strict;
use warnings;
use subs;
use CGI;
use DBI;
use DBD::Oracle;
$|++;
my $dbh;


my $db_name="Oracle:xe";
my $user="SYSTEM";
my $password="ps";

my %first_table_object=(
	column_names => [ "filed1" , "field2" ],
	table_name =>  [ "table4" ]
);


my %second_table_object=(
	column_names => [ "BETA" , "PAST" ],
	table_name =>  [ "table3" ]
);
print qq(Content-type: text/html\n\n);

my $query = new CGI;
my $value1= $query->param('textbox');
my $value2= $query->param('dropDownvalue');
my $index=$query->param('index');
eval
{
       if ($value1 ne $value2 )
       {
	$dbh = DBI->connect("DBI:$db_name",
                         $user, $password,
                         {'RaiseError' => 1 , ShowErrorStatement => 1 , PrintError=>1 } );
       }
};
if($@)
{
	print $@;
	die("couldn't connect $@");
}


my $sth;
eval
{


#	 my %current_hash_obj;
	 if ($index == 0 )
         {


	  if( $value1 eq $value2 )
          {
	     	print " page1 value same error "   ;
		exit;
          }
	
          
	  # we may change to insert into table_name(column1,column2)  values(?,?)
         $sth=$dbh->prepare("insert into $first_table_object{table_name}[0] ($first_table_object{column_names}[0] , $first_table_object{column_names}[1] )  values(  ?, ? )") or die $dbh->errstr;
	}
         else
         {
	
	  if( $value1 eq $value2 )
          {
	     	print " page2 value same error " ;
		exit;
          }
	
	  # we may change to insert into table_name(column1,column2)  values(?,?)
         $sth=$dbh->prepare("insert into $second_table_object{table_name}[0] ($second_table_object{column_names}[0] , $second_table_object{column_names}[1] )  values(  ?, ? )") or die $dbh->errstr ;
         }

	 if(defined($sth))
	 {
	 $sth->execute($value1,$value2);
         }
	 else
	 {
		 $dbh->disconnect;
		 die("Sth not defined");
	 }
#	$dbh->do("insert into $inserted_table values(  $value1, $value2 )");
};
if($@)
{
          print $@;
	  $sth->finish();
	  $dbh->disconnect;
	  die("ERROR $@");
}
if($index==0 )
{



$sth->finish();
$dbh->disconnect;
print " view page1 inserted successfuly " ;
}
else
{

$sth->finish();
$dbh->disconnect;
print " view page2 inserted successfuly " ;
}
