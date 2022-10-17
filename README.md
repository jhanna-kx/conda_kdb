# conda_kdb
conda_kdb
## Build

put l64/m64/w64.zip in this directory then follow build instructions

build with 
```
q conda_build.q
```

### Windows

you need 7z installed, to avoid conda wrapper scripts when running conda_build.q  use
```
 C:\q\w64\q.exe conda_build.q
```


## Upload
Get the upload token to upload to kx channel then

```
$ anaconda -t $CONDAUPLOADTOKEN upload -l dev PATHTOARCHIVE
```

note -t option must come before upload above, error message won't be helpful if it doesn't

