# Load test

Load and stress testing with Gatling in a Docker container

List with urls have to be given a a csv format in the resource folder


## Build Docker container

    rake build

## Run a simulation

    rake test

## Run specific simulation

    rake test simulation=loadtest.multiurl

## Run a specific simulation with custom settings

    rake test simulation=loadtest.multiurl users=50 duration=50

## See rapports

Reports will be found in the `results` folder.
