#!/usr/bin/perl
###### usage: cat inputfile | abiglobal.pl



$i=0;
while ($_ = <STDIN>) {

if(/(FUND ACTIVITY REPORT)/ ) {

	$input=$_;
	chop($input);
	$fundcode=substr($input,0,5);
	$fundcode=~ s/ //g;
	$input=~ tr/\"//;
	$input=~ tr/\'//;
#	$input=~ tr/,/\t/;
	$input=~s/REPORT,/REPORT  /g;
	$input=~s/   /  /g;
	@in=split(/  /,$input);

#	@fund=$in[0];
	
	if($i=="0"){
	$final=$in[3].".html";
	open (OUT,">>body.txt") || die "I am not able to write to file";
	open (HEAD,">>head.txt") || die "not able to open temp header";
	print HEAD "<HTML><HEAD><TITLE>Fund Activity Report</TITLE></HEAD><BODY><TABLE border=1><tr><td><strong>Fund Activity Reports:   $in[3]</strong></td></tr><TR><td valign='top'><a href='#$fundcode'>$fundcode</a>&nbsp;\n";
	$i=99;
	}
	print HEAD "<a href='#$fundcode'>$fundcode</a>&nbsp;\n";
	print OUT "<strong><a name='$fundcode'>Fund: <u>$in[0]</u> </a>FundInfo: <u>$in[1] $in[2]</u></strong><br>\n";
	
}
	else {
	print OUT "<pre>$_</pre>\n";
	}


} #### end while stdin
print HEAD "</td></tr></table><br><br>\n";
print OUT "</body></html>\n";
close OUT;
close HEAD;

#$outfile=~tr/ /_/;
#$outfile=~tr/,/_/;
print "$outfile\n";
system "cat head.txt body.txt > /data/www/htdocs/fundlist/public_html/$final";
system "rm head.txt";
system "rm body.txt";

opendir(DIR, "./public_html");
	open (OUT,"> /data/www/htdocs/fundlist/public_html/index.html") || die "I am not able to write to file";
print OUT ("<HTML><HEAD><TITLE>Fund List Directory</TITLE></HEAD><BODY>\n");
print OUT ("<h4>Directory Listing</h4>\n");

while($file = readdir(DIR) ) {

print OUT ("<A HREF=\"$file\">$file<br>\n");

}
print OUT ("</body></html>\n");
closedir(DIR);
close (OUT);

