describe('Test httpsConnectivity Tests', () => {
  it('Tests https connection', () => {
    cy.visit('https://resume.shellflow.com')
  }),
  it('test http connection, should fail', () => {
    cy.visit('http://resume.shellflow.com')
  })
})