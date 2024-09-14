describe("Albums", () => {
  context("add new album", () => {
    it("adds new album to the album list", () => {
      cy.intercept("POST", "/albums").as("submitAlbum");

      cy.visit("/");
    });
  });
});
