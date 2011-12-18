<h1>Minion Pro</h1>

There are a few walkthroughs online for installing Minion Pro. The two that standout are <a href="http://carlo-hamalainen.net/blog/?p=8">Carlo Hamalainen's</a> and <a href="http://jklukas.blogspot.com/2010/02/installing-minionpro-tex-package.html">Jeff Klukas's</a>. Using both of those as a guide I have created a bash script that runs with very little user intervention. The major caveat is that there is also very little error checking, so if a step fails the script usually continues, I might fix this later.


<ol>
  <li>Grab <a href="MinionProforLaTeX.sh">MinionProforLaTeX.sh</a></li>
  <li>Locate Minion Pro files and change that variable at the beginning of the script. (minion_folder)</li>
  <li>Determine which version of Minion Pro you have, and change which encoding file is used at the beginning of the script. (encoding)</li>
</ol>