jest.dontMock '../ListItem.coffee'

describe 'ListItem', ->

  React = require 'react/addons'
  Immutable = require 'immutable'
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
      kids: [1, 2, 3]
    }
    listItem = TestUtils.renderIntoDocument React.createElement(ListItem, {item: item})

  it 'should exists', ->
    expect(TestUtils.isCompositeComponent(listItem)).toBeTruthy()

  it 'should create a li with two spans', ->
    li = TestUtils.findRenderedDOMComponentWithTag listItem, 'li'
    spans = TestUtils.scryRenderedDOMComponentsWithTag li, 'span'
    expect(spans.length).toBe 2

    a = TestUtils.findRenderedDOMComponentWithTag spans[0], 'a'
    expect(React.findDOMNode(a).textContent).toBe item.get('title')
    expect(React.findDOMNode(a).getAttribute('href')).toBe item.get('url')

    expect(spans[1].getDOMNode().textContent).toBe item.get('descendants').toString()

  it 'should get comments when the descendants span is clicked', ->
    Actions = require '../../actions/Actions.coffee'
    li = TestUtils.findRenderedDOMComponentWithTag listItem, 'li'
    spans = TestUtils.scryRenderedDOMComponentsWithTag li, 'span'
    comments = React.findDOMNode(spans[1])
    TestUtils.Simulate.click(comments)
    expect(Actions.clickComments).toBeCalledWith item.get('kids')




