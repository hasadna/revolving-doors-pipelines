# Revolving Doors Pipelines

Visualization and research aids to work with revolving doors data

Uses the [datapackage pipelines framework](https://github.com/frictionlessdata/datapackage-pipelines)


## Running the pipelines locally

Most pipelines are available to run locally with minimal infrastructure dependencies.

Install some dependencies (following works for latest version of Ubuntu):

```
sudo apt-get install -y python3.6 python3-pip python3.6-dev libleveldb-dev libleveldb1v5
sudo pip3 install pipenv
```

install the pipeline dependencies

```
pipenv install
```

activate the virtualenv

```
pipenv shell
```

List the available pipelines

```
dpp
```

run a pipeline

```
dpp run <PIPELINE_ID>
```


## running using docker

```
docker pull orihoch/knesset-data-pipelines
docker run -it --entrypoint bash -v `pwd`:/pipelines orihoch/knesset-data-pipelines
```

Continue with `Running the pipelines locally` section above

You can usually fix permissions problems on the files by running inside the docker `chown -R 1000:1000 .`
