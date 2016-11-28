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
function viewpage()
{
\$.ajax({
   url: "viewinfo.pl",
  cache: false,
  async: false,
  success: function(html){
    \$("#mycontainer").append(html);
  }
});

}
</script>

<div class="dropdown" onmouseover="viewpage()" id="test">
  <button class="dropbtn">View Page</button>
  <div class="dropdown-content" id="mycontainer" >
    </div>
</div>

<div id="jq-dropdown-1" class="jq-dropdown jq-dropdown-tip"></div>
</body>
</html>
EOT
;
print $html;

