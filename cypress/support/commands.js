// ***********************************************
// This example commands.js shows you how to
// create various custom commands and overwrite
// existing commands.
//
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************
//
//
// -- This is a parent command --
// Cypress.Commands.add('login', (email, password) => { ... })
//
//
// -- This is a child command --
// Cypress.Commands.add('drag', { prevSubject: 'element'}, (subject, options) => { ... })
//
//
// -- This is a dual command --
// Cypress.Commands.add('dismiss', { prevSubject: 'optional'}, (subject, options) => { ... })
//
//
// -- This will overwrite an existing command --
// Cypress.Commands.overwrite('visit', (originalFn, url, options) => { ... })

var DB_SEED_TIMEOUT = 5000;

Cypress.Commands.add("reseed", (timeout) => {
  cy.exec("bundle exec rails db:seed", {
    timeout: timeout || DB_SEED_TIMEOUT,
  });
});

Cypress.Commands.add("login", (email, password) => {
  cy.request("post", "session_without_csrf", {
    session: {
      email: email,
      password: password,
    },
  });
  cy.getCookie("remember_token").should("exist");
});

Cypress.Commands.add("logout", () => {
  cy.request("delete", "session_without_csrf");
  cy.getCookie("remember_token").should("not.exist");
});
