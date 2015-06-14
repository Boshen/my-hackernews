jest.dontMock '../ListItem.coffee'

describe 'ListItem', ->
  Immutable = require 'immutable'

  React = require 'react/addons'
  TestUtils = React.addons.TestUtils
  ListItem = null

  item = listItem = null

  beforeEach ->
    ListItem = require '../ListItem.coffee'

    item = new Immutable.Map {
      id: 1
      descendants: 2
      score: 3
      url: 'http://test.com'
      title: 'Story Title'
    }
    listItem = TestUtils.renderIntoDocument React.createElement(ListItem, {item: item})

  it 'should exists', ->
    expect(TestUtils.isCompositeComponent(listItem)).toBeTruthy()

  it 'should create a li with three spans', ->
    li = TestUtils.findRenderedDOMComponentWithTag listItem, 'li'
    spans = TestUtils.scryRenderedDOMComponentsWithTag li, 'span'
    expect(spans.length).toBe 3

    expect(spans[0].getDOMNode().textContent).toBe item.get('descendants').toString()
    expect(spans[1].getDOMNode().textContent).toBe item.get('score').toString()

    a = TestUtils.findRenderedDOMComponentWithTag spans[2], 'a'
    expect(a.getDOMNode().textContent).toBe item.get('title')
    expect(a.getDOMNode().getAttribute('href')).toBe item.get('url')
