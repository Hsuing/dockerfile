```
docker build --build-arg app=${project} -t ${project}:latest-f ${project}-dockerfile .
docker tag ${project}:latest dockerhub.com/${project}:laster
docker push dockerhub.com/${project}:test
```

