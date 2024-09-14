describe("Albums", () => {
  beforeEach(() => {
    cy.reseed();
  });

  context("add new album", () => {
    it("adds new album to the album list", () => {
      cy.login('user@example.com', 'password');
      cy.intercept("POST", "/albums").as("submitAlbum");

      cy.visit("/");
      cy.get('[data-cy^="album-"]').should('have.length', 3);
      cy.get('[data-cy="new-album"]').click();
      cy.get('.modal').should('be.visible');
      cy.get('[data-cy="upload-cover-text"]').should('contain.text', 'Add cover');
      cy.get('input[type=file]').selectFile('db/cover_images/happier_than_ever.png', { force: true });
      cy.get('[data-cy="upload-cover-text"]').should('contain.text', 'Change cover');
      cy.get('[data-cy="album-name-input"]').type('New Album for test');
      cy.get('[data-cy="add-track-button"]').click();
      cy.get('[data-cy="track-item"]').not('.hidden').should('have.length', 1);
      cy.get('[data-cy="add-track-button"]').click();
      cy.get('[data-cy="track-item"]').not('.hidden').should('have.length', 2);
      cy.get('[data-cy="add-track-button"]').click();
      cy.get('[data-cy="track-item"]').not('.hidden').should('have.length', 3);
      cy.get('[name="album[tracks_attributes][0][title]"]').type('Track 1');
      cy.get('[name="album[tracks_attributes][0][artist]"]').type('Artist 1');
      cy.get('[name="album[tracks_attributes][0][duration]"]').type('120');
      cy.get('[name="album[tracks_attributes][1][title]"]').type('Track 2');
      cy.get('[name="album[tracks_attributes][1][artist]"]').type('Artist 2');
      cy.get('[name="album[tracks_attributes][1][duration]"]').type('300');
      cy.get('[name="album[tracks_attributes][2][title]"]').type('Track 3');
      cy.get('[name="album[tracks_attributes][2][artist]"]').type('Artist 3');
      cy.get('[name="album[tracks_attributes][2][duration]"]').type('330');

      cy.get('[data-cy="remove-track"]').first().click();
      cy.get('[data-cy="track-item"]').not('.hidden').should('have.length', 2);

      cy.get('[data-cy="submit-album"]').click();
      cy.wait('@submitAlbum');
      cy.get('[data-cy^="album-"]').should('have.length', 4);
    });
  });

  it("updates existing album to the album list", () => {
    cy.login('user@example.com', 'password');
    cy.intercept("POST", "/albums/*").as("updateAlbum");

    cy.visit("/");
    cy.get('[data-cy^="album-"]').should('have.length', 3);
    cy.get('[data-cy="edit-1"]').click();
    cy.get('.modal').should('be.visible');
    cy.get('[data-cy="upload-cover-text"]').should('contain.text', 'Change cover');
    cy.get('[data-cy="album-name-input"]').type('{selectAll}Updated Album name');
    cy.get('[data-cy="track-item"]').not('.hidden').should('have.length', 3);
    cy.get('[data-cy="add-track-button"]').click();
    cy.get('[data-cy="track-item"]').not('.hidden').should('have.length', 4);
    cy.get('[name="album[tracks_attributes][3][title]"]').type('Track 4');
    cy.get('[name="album[tracks_attributes][3][artist]"]').type('Artist 4');
    cy.get('[name="album[tracks_attributes][3][duration]"]').type('430');
    cy.get('[data-cy="submit-album"]').click();
    cy.wait('@updateAlbum');

    cy.get('[data-cy="alb-title-1"]').should('contain.text', 'Updated Album name');
    cy.get('[data-cy="track-9-title"]').should('contain.text', 'Track 4');
  });

  it("deletes existing album from the album list", () => {
    cy.login('user@example.com', 'password');
    cy.intercept("POST", "/albums/*").as("deleteAlbum");

    cy.visit("/");
    cy.get('[data-cy^="album-"]').should('have.length', 3);
    cy.get('[data-cy="delete-2"]').click();
    cy.wait('@deleteAlbum');
    cy.get('[data-cy^="album-"]').should('have.length', 2);
  });

  it("publishes album from the album list", () => {
    cy.login('user@example.com', 'password');
    cy.intercept("POST", "/albums/*/publish").as("publishAlbum");

    cy.visit("/");
    cy.get('[data-cy="publish-text-1"]').should('not.exist');
    cy.get('[data-cy="publish-1"]').click();
    cy.wait('@publishAlbum');
    cy.get('[data-cy="publish-text-1"]').should('contain.text', 'Published');
  });
});
