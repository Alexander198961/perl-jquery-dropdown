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
\$("#maincontainer").val(selectedText)
\$("#droplist").html("")
}
function unhide()
{
   
 \$("#maincontainer").removeAttr("hidden");
}

function capture()
{
var input=\$("#maincontainer").val().toString()

value="viewinfo.pl?name=".concat(input)
\$.ajax({
   url: value,
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

<form action="">
<textarea id="maincontainer"  hidden="true" onkeyup="capture()"></textarea>
<div id="droplist"></div>
<p><a  href="#" onclick="unhide()">Input</a> </p>
<input type="submit" value="Submit"></input>
</form>

</body>
</html>
EOT
;
print $html;

