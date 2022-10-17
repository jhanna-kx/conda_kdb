{x set getenv x}each `QLIC`QHOME;
if[.z.o like"w*";
 -2 "******************************************************************\n",
    "IF THIS FAILS FOR ANY REASON, RUN THIS TO DEBUG\n",
    "******************************************************************\n",
    "conda build --croot /tmp --no-long-test-prefix --no-include-recipe .\n",
    "******************************************************************"
 ];
sstring:{$[10=type x;;string]x}
fexist:{x~key x:hsym`$sstring x}
licexist:{any fexist each(x,"/"),/:string(`kc.lic;`k4.lic)}
licloc:$[licexist QLIC;QLIC;licexist QHOME;QHOME;licexist".";system"cd";'"licence not found"]
system$[.z.o like"w*";"7z x -y ";"unzip -o "],(o:string .z.o),".zip";
`QLIC`QHOME setenv'(licloc;system"cd");
qver:system"echo .z.K,.z.k|",o,$[.z.o like"w*";"\\";"/"],"q -q"
`QVER`QBUILD setenv'(.Q.fmt[3;1;value qver 0];qver[1]except ".");
file:first u@-1+where (u:system"conda build --croot /tmp --no-long-test-prefix --no-include-recipe .")like "anaconda_upload is not set*"
-1"\nNow run\n", "\t anaconda -t $CONDAUPLOADTOKEN upload -l dev ",file;
-1"JH: if you don't see a file name here ending in bz2, conda build has likely changed the output format, rerun without exit 0 and look at the output of the conda build system command":

exit 0




   
