# An Octopress docker image
The Dockerfile in this repository builds a Docker image that contains octopress as well as additional dependencies
I use to build [my blog](https://humburg.github.io), especially pandoc and xelatex.

All octopress files are located in `/octopress`. To use this with your own (existing) blog simply 
mount your octopress directory in that location:

```
docker run -ti -v $(pwd):/octopress -p 4000:4000 humburg/octopress bash
```

Then run the usual rake commands inside the container. If you use any additional gem files with your 
blog you'll want to run `rake install` first. Avoid having to do that repeatedly by commiting the changes
to a new image.
