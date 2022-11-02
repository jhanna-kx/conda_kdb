
{x set getenv x}each `QLIC`QHOME;
/ q conda_build.q [-variants CONDAVARIANTS]
/ CONDAVARIANTS is a space separated list of conda variants like linux-64 osx-64 osx-arm64
/ will build for current platform with no variants option, but can cross build at least mac and linux (probably l64arm down the line) on linux , windows still needs to be built on windows
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
vz:("linux-64";"linux-arm64";"osx-64";"osx-arm64";"win-64")!string` sv'`l64`l64arm`m64`m64`w64,\:`zip
uz:{system$[.z.o like"w*";"7z x -y ";"unzip -o "],x}
chkv:{uz x;qver:system"grep '^k:.*;K:.*;' q.k|cut -d ';' -f1,2|xargs printf '%s;(k;K)\n'|q  -q";(.Q.fmt[3;1;value qver 0];qver[1]except ".")} / check version in current q.k
if[count v:.Q.opt[.z.x]`variants;
 if[not all u:fexist each vz v;'"missing ",","sv":"sv'(::;vz)@\:/:v where not u];
 if[1<count distinct qver:chkv each vz v;'"more than one distinct kdb+ build (.z.K;.z.k) found, check zips in this directory"];qver:first qver;
 ];
if[not count v;
 qver:chkv string` sv .z.o,`zip;
 ];
`QVER`QBUILD`QLIC`QHOME setenv'qver,(licloc;system"cd");
-1"export QVER=",getenv`QVER;
-1"export QBUILD=",getenv`QBUILD;
fcv:{$[count x;"--variants '",.j.j[(1#`target_platform)!enlist x],"'";""]}
cbs:"conda build --croot /tmp --no-long-test-prefix --no-include-recipe . ",fcv v;
-1"will run\n\n",cbs,"\n";
files:first(1 0+{first where x like y}[u]each("anaconda upload \\";"anaconda_upload is not set*"))cut u:system cbs;
-1"\nNow run","\n\t"sv("";"anaconda -t $CONDAUPLOADTOKEN upload -l dev \\"),files; / \n\tanaconda -t $CONDAUPLOADTOKEN upload -l dev \\\n\t",files
-1"JH: if you don't see file names here ending in bz2, conda build has likely changed the output format, rerun without exit 0 and look at the output of the conda build system command";





   
