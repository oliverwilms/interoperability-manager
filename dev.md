# useful commands
## clean up docker 
```
docker system prune -f
```

## build container with no cache
```
docker-compose build --no-cache
```

## start container
```
docker-compose up -d
```

## open terminal to docker
```
docker-compose exec iris iris session iris -U COFFEE
```
## debug CSP
```
kill ^%ISCLOG

kill ^ISCLOG

set ^%ISCLOG=3
```

## export a global in runtime into the repo
```
d $System.OBJ.Export("GlobalD.GBL","/irisrun/repo/src/gbl/GlobalD.xml")
```

## select zpm test registry
```
repo -n registry -r -url https://test.pm.community.intersystems.com/registry/ -user test -pass PassWord42
```



