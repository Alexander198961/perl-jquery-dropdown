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
function select(el)
{

var selector="#".concat(el.id)
var selectedText=\$(selector).val()
\$("#dropDownvalue").val(selectedText)
}
function unhide()
{
   

 \$("#maincontainer").removeAttr("hidden");
 \$("#submit").removeAttr("hidden");
capture()
}

function capture()
{
\$.ajax({
   url: "viewinfo.pl",
  cache: false,
  async: false,
  success: function(html){
    \$("#droplist").html(html);
  }
  ,
  fail: function()
  {
	alert("failed")	   
  }	  
});
}
function viewpage(name)
{
 value="viewinfo.pl?name=".concat(name)
alert(value)

\$.ajax({
   url: value,
  cache: false,
  async: false,
  success: function(html){
    \$("#mycontainer").append(html);
  }
});

}
</script>

<form action="viewinfo.pl" method="post">
<table><tr><td style="vertical-align: top;"> <input type="button" onclick="unhide()" value="View Page"  /> </td><td id="droplist"></td><td style="vertical-align: top;"><input id="maincontainer" type="text"  hidden="true" onkeyup="captures()" name="textbox" /></td>  <td style="vertical-align: top;"><input type="submit" value="Submit" hidden="true" id="submit" /> </td> </tr></table>

<input type="hidden" name="dropDownvalue" id="dropDownvalue" />
<input type="hidden" name="sumbitForm" value="1" />
</form>

</body>
</html>
EOT
;
print $html;

