{x set getenv x}each `QLIC`QHOME;
sstring:{$[10=type x;;string]x}
fexist:{x~key x:hsym`$sstring x}
licexist:{any fexist each(x,"/"),/:string(`kc.lic;`k4.lic)}
licloc:$[licexist QLIC;QLIC;licexist QHOME;QHOME;licexist".";system"cd";'"licence not found"]
system$[.z.o like"w*";"7z x -y ";"unzip -o "],(o:string .z.o),".zip";
`QLIC`QHOME setenv'(licloc;system"cd");
qver:system"echo .z.K,.z.k|",o,"/q -q"
`QVER`QBUILD setenv'(.Q.fmt[3;1;value qver 0];qver[1]except ".");
file:count["anaconda upload "]_first u where (u:system"conda build --croot /tmp --no-long-test-prefix --no-include-recipe .")like "anaconda upload*bz2";
-1"\nNow run\n", "\t anaconda -t $CONDAUPLOADTOKEN upload -l dev ",file;

exit 0




   
