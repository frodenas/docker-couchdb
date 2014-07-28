# CouchDB Dockerfile

A Dockerfile that produces a Docker Image for [Apache CouchDB](http://couchdb.apache.org/).

## CouchDB version

The `master` branch currently hosts CouchDB 1.6.

Different versions of CouchDB are located at the github repo [branches](https://github.com/frodenas/docker-couchdb/branches).

## Usage

### Build the image

To create the image `frodenas/couchdb`, execute the following command on the `docker-couchdb` folder:

```
$ docker build -t frodenas/couchdb .
```

### Run the image

To run the image and bind to host port 5984:

```
$ docker run -d --name couchdb -p 5984:5984 frodenas/couchdb
```

The first time you run your container, a new user `couchdb` with all privileges will be created with a random password.
To get the password, check the logs of the container by running:

```
docker logs <CONTAINER_ID>
```

You will see an output like the following:

```
========================================================================
CouchDB User: "couchdb"
CouchDB Password: "jPp5fBJySeuJPTN8
========================================================================
```

#### Credentials

If you want to preset credentials instead of a random generated ones, you can set the following environment variables:

* `COUCHDB_USERNAME` to set a specific username
* `COUCHDB_PASSWORD` to set a specific password

On this example we will preset our custom username and password:

```
$ docker run -d \
    --name couchdb \
    -p 5984:5984 \
    -e COUCHDB_USERNAME=myusername \
    -e COUCHDB_PASSWORD=mypassword \
    frodenas/couchdb
```

#### Databases

If you want to create a database at container's boot time, you can set the following environment variables:

* `COUCHDB_DBNAME` to create a database

On this example we will preset our custom username and password and we will create a database:

```
$ docker run -d \
    --name couchdb \
    -p 5984:5984 \
    -e COUCHDB_USERNAME=myusername \
    -e COUCHDB_PASSWORD=mypassword \
    -e COUCHDB_DBNAME=mydb \
    frodenas/couchdb
```

#### Persistent data

The CouchDB server is configured to store data in the `/data` directory inside the container. You can map the
container's `/data` volume to a volume on the host so the data becomes independent of the running container:

```
$ mkdir -p /tmp/couchdb
$ docker run -d \
    --name couchdb \
    -p 5984:5984 \
    -v /tmp/couchdb:/data \
    frodenas/couchdb
```

## Copyright

Copyright (c) 2014 Ferran Rodenas. See [LICENSE](https://github.com/frodenas/docker-couchdb/blob/master/LICENSE) for details.
