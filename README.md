# teamcity-exporter

Scrapes status of projects build for its master branch using the TeamCity API and publishes it to a HTTP endpoint in Prometheus format.

## Getting Started

### Installing

1. Modify the `docker-compose.yml` file to fit your environment.
2. Run `$ docker-compose up`.

## Running the tests

`$ ruby teamcity_exporter_test.rb`

## Authors

* **Allister Antosik** - *Initial work* - [PurpleBooth](https://github.com/allistera)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

