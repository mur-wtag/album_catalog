# Album Catalog

## Steup

Just `bundle`
```shell
$ bundle
```

To run Cypress E2E tests, run:
```shell
$ yarn install
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
