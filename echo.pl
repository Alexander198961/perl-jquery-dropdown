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
<style>
.dropbtn {
    background-color: #4CAF50;
    color: white;
    padding: 16px;
    font-size: 16px;
    border: none;
    cursor: pointer;
}

.dropdown {
    position: relative;
    display: inline-block;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
}

.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}

.dropdown-content a:hover {background-color: #f1f1f1}

.dropdown:hover .dropdown-content {
    display: block;
}

.dropdown:hover .dropbtn {
    background-color: #3e8e41;
}
</style>
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
</form>

</body>
</html>
EOT
;
print $html;

