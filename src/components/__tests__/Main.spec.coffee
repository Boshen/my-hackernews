jest.dontMock '../main.coffee'

describe 'main', ->
  React = require 'react/addons'
  TestUtils = React.addons.TestUtils
  Main = require '../main.coffee'

  main = null

  # firebase array
  items = {
    1: 1
    2: 2
    3: 3
  }

  beforeEach ->
    main = TestUtils.renderIntoDocument React.createElement(Main, null)
    #main.setState items: items

  #it 'should exists', ->
    #expect(TestUtils.isCompositeComponent(main)).toBeTruthy()

  it 'should render items into a list', ->
    expect(main.getDOMNode().textContent).toBe 'Hello, World!'
    expect(main.getDOMNode().childElementCount).toBe 3
