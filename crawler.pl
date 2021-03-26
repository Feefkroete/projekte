use strict;
use feature "switch";
use diagnostics;
use warnings;
use v5.16;
use Time::HiRes qw ( sleep );
use LWP::Simple;
use open ':std', ':encoding(UTF-8)';
use Term::ANSIColor qw(:constants);

my $suchindex = 0;
my $href = 'href="';
my $filewriter;
my $file = "links.txt";
my $indexzaehler = 0;
my $link;
my $bisindex;
my $indexhttps = 0;
my $indexhttp = 0;
my $basedomain = 0;
my $zertifikat = 0;
my $positionimfile = 0;
my $x = 0;
my $filereader;
my $zeile;
my $existiert = 0;
my $htmlFile;
my $site;

HAUPTMENU:

print BLACK;
print("Matthi's basic Webcrawler (V.1.1)\n");
print("\n");
print("Bitte eine Option waehlen:\n");
print("1: URL eingeben und neuen Crawlvorgang beginnen\n");
print("2: An bestimmter Stelle in der Liste fortfahren\n");
print RESET;

chomp(my $userinput = <STDIN>);
if($userinput eq "1")
{
  system("clear");
  print("Bitte website eingeben.\n");
  chomp($site = <STDIN>);
  system("clear");
  $htmlFile = get($site) or goto INKORREKTEURL;
}
if($userinput eq "2")
{
  system("clear");
  print("Bitte Listenpunkt eingeben.\n");
  chomp($positionimfile = <STDIN>);
  sleep(1);
  system("clear");
  goto WEITER;
}


WIEDERHOLEN:

$htmlFile = get($site) or goto NEXTDOMAIN;

if (index($site, "http://") != -1)
{
  $basedomain = substr($site, 7, length($site));
  $zertifikat = "http://";
}
if (index($site, "https://") != -1)
{
  $basedomain = substr($site, 8, length($site));
  $zertifikat = "https://";
}
$basedomain = substr($basedomain, 0, index($basedomain, "/"));
$basedomain = "$zertifikat$basedomain/";
print BLUE;
print ("BASEDOMAIN $basedomain\n");
print RESET;

while ($suchindex != -1)
{
  $suchindex = index($htmlFile, $href);

  my $htmlFile1 = substr($htmlFile, 0, $suchindex);
  my $htmlFile2 = substr($htmlFile, $suchindex + length("$href"), length($htmlFile));
  # Durchsucht die Website nach links und teilt das HTML-file an der Stelle in 2

  if ($suchindex != -1)
  {
    $indexzaehler++;
    #Zählt die Links

    $bisindex = index($htmlFile2, '"'); # das nächste Abführungszeichen nach dem Link suchen
    $link = substr($htmlFile, $suchindex + 6, $bisindex);

    $indexhttp = index($link, "http://");
    $indexhttps = index($link, "https://");

    if ($indexhttp == -1 && $indexhttps == -1)
    {
      $link = $basedomain . $link;
    }

    #print("Position $suchindex: $link\n");

    $existiert = 0;

    open $filereader, '<', $file;
    while($zeile = <$filereader>)
    {
      chomp $zeile;
      if ($zeile eq $link)
      {
        $existiert = 1;
        last;
      }

    }
    close $filereader;

    if ($existiert == 0 && index($link, ".exe")== -1 && index($link, "mailto:")== -1 && index($link, ".zip")== -1
    && index($link, ".msi")== -1 && index($link, ".7z") == -1 && index($link, "youtube") == -1 && index($link, "wikipedia") == -1)
    {
      open $filewriter, '>>', $file;
      print $filewriter ("$link\n");
      close $filewriter;
    }
    $existiert = 0;
  }

  $htmlFile = $htmlFile1 . $htmlFile2; # Das ursprüngliche Html-file ohne dem zuletzt kopieren Link zusammensetzen

}

sleep(0.05);
print("Es wurden $indexzaehler Links gefunden.\n");
$zertifikat = 0;

goto WEITER;

NEXTDOMAIN:

print RED;
print("Domain nicht korrekt. Naechste wird genommen.");
print RESET;

WEITER:

open $filereader, '<', $file;

while ($zeile = <$filereader>)
{
  chomp $zeile;
  if($x<=$positionimfile)
  {
    $x++;
    $site = $zeile;
  }
}
close $filereader;
print GREEN;
print("\n");
print("\n");
print("Link $positionimfile wird geladen: $site\n");
print RESET;
$positionimfile++;
$x = 0;
$indexzaehler = 0;
$suchindex = 0;

sleep(0.05);
goto WIEDERHOLEN;

INKORREKTEURL:
print("Inkorrekte URL. Bitte mit http:// bzw. https:// und www. angeben!\n");
print("\n");
sleep(2.5);
goto HAUPTMENU;
#13503
