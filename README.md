# Album Catalog
An album catalog for the music professionals

## Features
- User can sign up using email add password
- Singed in user can create Album with `cover image`, `title`, `multiple tracks` (in track user can define `track name`, `artist name`, `duration for the track in seconds`)
- Signed in user can `edit`, `destroy` the album (user who created the album)
- Signed in user can `publish` the album, once the album get published it cannot be be modified
- Album listing page have `pagination`, each page should have 10 albums
- Guest users only can `view` the `published` albums

## Setup

Just `bundle` ruby gems (make sure dependent `ruby` version is installed in your system)
```shell
$ bundle
```

Yarn all js libraries (make sure dependent `node` is installed in your system)
```shell
$ yarn install
```

Create database using:
```shell
$ bin/rails db:create db:migrate
```

You can load the application with seed data if you want, please use:
```shell
$ bin/rails db:seed
```

### Running the project

This projects uses [Foreman](https://github.com/ddollar/foreman) to run multiple processes for local development. Launch the app and the CSS building process by running:

```sh
$ bin/dev
```

### Rubocop
The project uses [Rubocop](https://github.com/rubocop/rubocop) to lint code and enforce coding standards. We run Rubucop as part of the CI/CD process and it will fail builds if it detects any issues.

To check your code locally you can run:

```sh
$ bin/bundle exec rubocop
```

### RSpec
For different unit and integration tests I am using `RSpec`. To run:
```shell
bundle exec rspec
```

### ESLint
The project uses ESLint to lint JavaScript code and enforce coding standards. We run ESLint as part of the CI/CD process, and it will fail builds if it detects any issues

To check your code locally you can run:

```sh
Show issues:
yarn eslint [FOLDER_NAME]

Apply automatic fixes:
yarn eslint --fix [FOLDER_NAME]
```

### End-to-end tests

[Cypress](https://www.cypress.io) is being used for E2E tests. These are run automatically on the Github CI machine when the project is built. However, for development it's easier to run the tests locally.

To do so run `bin/dev` in one terminal window to handle the server separately. Then run `bin/yarn cypress` in a different terminal window to launch the Cypress interface and select "E2E testing".

### Github actions - CI/CD
On each commit being pushed to the repo we're running a CI workflow defined in `.github/workflows/workflow.yml`. The workflow is split into three separate parts:
* Linting and quality checks (`rubocop` and `eslist`)
* RSpec
* E2E tests

## Deployment
Continuous deployment done in Heroku!

Cheers!
