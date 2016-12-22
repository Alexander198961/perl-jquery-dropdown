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

    \$("#view2").attr("hidden",1)
    capture(0)
}
function select_from_view()
{
var selectedView=\$("#select_view").val()
if (selectedView == "View Page1")
{
   \$("#view1").removeAttr("hidden");

    \$("#view2").attr("hidden",1)

    \$("#capture_relult1").html("")
    capture(0)
}
else
{
\$("#view2").removeAttr("hidden");


    \$("#view1").attr("hidden",1)

    \$("#capture_relult0").html("")
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
 var capture_relultId="#capture_relult"+id
 var dropDownValue=\$(dropDownId).val() 
 var maincontainerId="#maincontainer"+id
 var maincontainerValue=\$(maincontainerId).val()
  url_location="action.pl?index="+id+"&dropDownvalue="+dropDownValue+"&textbox="+maincontainerValue
  \$.ajax({
   url: url_location ,
  cache: false,
  async: false,
  success: function(html){


    \$(capture_relultId).html(html);
  }
  ,
  fail: function()
  {

    \$(capture_relultId).html("fail");
  }      
});

}
count=0
function selector()
{
count++
if(count%2 == 0)
{
if(\$("#view2").attr("hidden") == "hidden")
{
  \$("#view1").removeAttr("hidden");

    \$("#view2").attr("hidden",1)

    \$("#capture_relult1").html("")
    capture(0) 
}
count=0
}


}
function view_description(option)
{
  if(option.id=="viewpage1")
  {
   \$("#description_label1").removeAttr("hidden");
    \$("#description_label2").attr("hidden",1)

  }
  else
  {
   \$("#description_label2").removeAttr("hidden");
    \$("#description_label1").attr("hidden",1)
  }
}
</script>

<p id="description_label1">View Page1 is about insert in first table</p>
<p id="description_label2" hidden="true">View Page2 is about insert in second table</p>
<p><select id="select_view"   onchange="select_from_view()" onclick="selector()"><option id="viewpage1" onclick="page_view(this)" onmouseover="view_description(this)">View Page1</option><option id="viewpage2"  onmouseover="view_description(this)">View Page2</option></select></p>

<form   id="view1" hidden="true">
<table  ><tr><td  id="label">Drop down list label 1 </td><td id="label1" > Text box label 1 </td><td></td></tr><tr><td id="droplist0"></td><td style="vertical-align: top;"><input id="maincontainer0" type="text"    name="textbox" /></td>  <td style="vertical-align: top;"><a href="#"  id="submit" onclick="sumbit_form(0)" >Sumbit</a> </td> <input type="hidden" name="dropDownvalue0" id="dropDownvalue0" /> </tr></table>


<p id="capture_relult0"></p>
</form>

<form  id="view2" hidden="true">
<table ><tr><td id="label">Drop down list label 2 </td><td id="label1" > Text box label 2 </td><td></td><td></td></tr><tr><td id="droplist1"></td><td style="vertical-align: top;"><input id="maincontainer1" type="text"  name="textbox" /></td> <td style="vertical-align: top;"><a href="#"  id="submit" onclick="sumbit_form(1)" >Sumbit</a> </td> <input type="hidden" name="dropDownvalue1" id="dropDownvalue1" /></tr></table>

<p id="capture_relult1"></p>
</form>
</body>
</html>
EOT
;
print $html;

