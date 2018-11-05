# conda_kdb
conda_kdb
##Build
put l64/m64/w64.zip in this directory then follow build instructions
increment the build number in meta.yaml (even if .z.k is later this seems to be required)
###Linux/macOS

build with 
```
./conda_build.sh
```

###Windows

set LICDIR to directory containing kc.lic/k4.lic, set QBUILD to .z.k of target kdb build
build with 
```
conda build --no-long-test-prefix --no-include-recipe .
```



##Upload
Get the upload token to upload to kx channel then

```
$ anaconda -t $CONDAUPLOADTOKEN upload -l dev PATHTOARCHIVE
```

note -t option must come before upload above, error message won't be helpful if it doesn't

