#!/usr/bin/perl
use strict;
use warnings;
use CGI;
print qq(Content-type: text/html\n\n);
my $html = <<EOT;
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.min.js"
        type="text/javascript"></script>
</head>
<body>
<script type="text/javascript">

if (typeof jQuery == 'undefined') {
 alert('jQuery is not loaded')
}
function page_view(value )
{
   \$("#view1").removeAttr("hidden");
    capture(0)
}
function select_from_view()
{
var selectedView=\$("#select_view").val()
if (selectedView == "View Page1")
{
   \$("#view1").removeAttr("hidden");
    capture(0)
}
else
{
\$("#view2").removeAttr("hidden");
 capture(1)
}
}
function select(id)
{
var mySelectId="#mySelect"+id
var dropDownvalue="#dropDownvalue"+id
var selectedText=\$(mySelectId).val()

\$(dropDownvalue).val(selectedText)
}

function capture( index)
{

var droplist="#droplist"+index

\$.ajax({
   url: "viewinfo.pl?index="+index,
  cache: false,
  async: false,
  success: function(html){
    \$(droplist).html(html);
  }
  ,
  fail: function()
  {
	alert("failed")	   
  }	  
});
 var mydropDownId="#dropDownvalue"+index
\$(mydropDownId).val(\$("#myid1").val())
}
function sumbit_form(id)
{
 var dropDownId="#dropDownvalue"+id
 var dropDownValue=\$(dropDownId).val() 
 var maincontainerId="#maincontainer"+id
 var maincontainerValue=\$(maincontainerId).val()
  url_location="action.pl?index="+id+"&dropDownvalue="+dropDownValue+"&textbox="+maincontainerValue
  \$.ajax({
   url: url_location ,
  cache: false,
  async: false,
  success: function(html){


    \$("#capture_relult").html("success");
  }
  ,
  fail: function()
  {

    \$("#capture_relult").html("fail");
  }      
});

}
</script>
<p><select id="select_view"   onchange="select_from_view()" ><option id="viewpage1" onclick="page_view(this)">View Page1</option><option id="viewpage2" >View Page2</option></select></p>

<form   id="view1" hidden="true">
<table  ><tr><td  id="label">Drop down list label </td><td id="label1" > Text box label </td><td></td></tr><tr><td id="droplist0"></td><td style="vertical-align: top;"><input id="maincontainer0" type="text"    name="textbox" /></td>  <td style="vertical-align: top;"><a href="#"  id="submit" onclick="sumbit_form(0)" >Sumbit</a> </td> <input type="hidden" name="dropDownvalue0" id="dropDownvalue0" /> </tr></table>
</form>
<p id="capture_relult"></p>
<form  id="view2" hidden="true">
<table ><tr><td id="label">Drop down list label </td><td id="label1" > Text box label </td><td></td><td></td></tr><tr><td id="droplist1"></td><td style="vertical-align: top;"><input id="maincontainer1" type="text"  name="textbox" /></td> <td style="vertical-align: top;"><a href="#"  id="submit" onclick="sumbit_form(1)" >Sumbit</a> </td> <input type="hidden" name="dropDownvalue1" id="dropDownvalue1" /></tr></table>
</form>
</body>
</html>
EOT
;
print $html;

