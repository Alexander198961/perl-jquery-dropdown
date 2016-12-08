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
\$("#dropDownvaule").val(selectedText)
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

<form action="action.pl">
<table><tr><td style="vertical-align: top;"> <a  href="#" onclick="unhide()">View Page</a> </td><td id="droplist"></td><td style="vertical-align: top;"><input id="maincontainer" type="text"  hidden="true" onkeyup="captures()" name="textbox" /></td>  <td style="vertical-align: top;"><input type="submit" value="Submit" hidden="true" id="submit" /> </td> </tr></table>
<tr><input type="hidden" name="dropDownvaule" id="dropDownvaule" /></tr>
</form>

</body>
</html>
EOT
;
print $html;

