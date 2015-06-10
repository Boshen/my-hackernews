jest.dontMock '../main.coffee'

describe 'main', ->
  React = require('react/addons')
  TestUtils = React.addons.TestUtils
  Main = require '../main.coffee'

  main = null

  beforeEach ->
    main = TestUtils.renderIntoDocument React.createElement(Main, null)

  it 'should exists', ->
    expect(TestUtils.isCompositeComponent(main)).toBeTruthy()

  it 'should display "Hello, World!"', ->
    expect(main.getDOMNode().textContent).toBe 'Hello, World!'
