[Docker Hub](https://hub.docker.com/r/codycraven/sassc/) |
[GitHub](https://github.com/codycraven/docker-sassc)

## Supported tags and respective `Dockerfile` links

* [`3.2.5`, `3.2` (_3.2/Dockerfile_)](https://github.com/codycraven/docker-sassc/blob/master/3.2/Dockerfile)
* [`3.3.6`, `3.3` (_3.3/Dockerfile_)](https://github.com/codycraven/docker-sassc/blob/master/3.3/Dockerfile)
* [`3.4.2`, `3.4`, `3`, `latest` (_3.4/Dockerfile_)](https://github.com/codycraven/docker-sassc/blob/master/3.4/Dockerfile)

## Usage

### View version

```bash
docker run --rm codycraven/sassc --version
```

### Sass compilation

```bash
docker run --rm -v $(pwd):/data codycraven/sassc scss/src.scss > css/dest.css
```

## About SassC

[SassC](https://github.com/sass/sassc) is a wrapper around
[LibSass](http://github.com/sass/libsass) to provide a faster alternative for
compiling Sass to CSS than Ruby.


## About Sass

Sass is a CSS pre-processor language to add on exciting, new, awesome features
to CSS. Sass was the first language of its kind and by far the most mature and
up to date codebase.

Sass was originally concieved of by the co-creator of this library, Hampton
Catlin ([@hcatlin](https://github.com/hcatlin)). Most of the language has been
the result of years of work by Natalie Weizenbaum
([@nex3](https://github.com/nex3)) and Chris Eppstein
([@chriseppstein](https://github.com/chriseppstein)).

For more information about Sass itself, please visit http://sass-lang.com

Initial development of SassC by Aaron Leung and Hampton Catlin was supported by
[Moovweb](http://www.moovweb.com/).
