jest.dontMock '../ListItem.coffee'

describe 'ListItem', ->

  React = require 'react/addons'
  Immutable = require 'immutable'
  TestUtils = React.addons.TestUtils
  ListItem = null

  item = element = null

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
    element = TestUtils.renderIntoDocument React.createElement(ListItem, {item: item})

  it 'should exists', ->
    expect(TestUtils.isCompositeComponent(element)).toBeTruthy()

  it 'should create a li with two spans', ->
    li = TestUtils.findRenderedDOMComponentWithTag element, 'li'
    spans = TestUtils.scryRenderedDOMComponentsWithTag li, 'span'
    expect(spans.length).toBe 2

    a = TestUtils.findRenderedDOMComponentWithTag spans[0], 'a'
    expect(React.findDOMNode(a).textContent).toBe item.get('title')
    expect(React.findDOMNode(a).getAttribute('href')).toBe item.get('url')

    expect(spans[1].getDOMNode().textContent).toBe item.get('descendants').toString()

  it 'should get comments when the descendants button is clicked', ->
    Actions = require '../../actions/Actions.coffee'
    button = TestUtils.findRenderedDOMComponentWithTag element, 'button'
    TestUtils.Simulate.click(React.findDOMNode(button))
    expect(Actions.clickComments).toBeCalledWith item.get('kids')

  xit 'should not show comments button if it does not have comments', ->
    # TODO: how do I test if an element does not exists?
    item = new Immutable.Map { id: 1 }
    element = TestUtils.renderIntoDocument React.createElement(ListItem, {item: item})
    expect(TestUtils.findRenderedDOMComponentWithTag(element, 'button')).toThrow()

  it 'should display comments', ->
    Comments = require '../Comments.coffee'
    expect(Comments.mock.calls[0][0]).toEqual {
      comments: undefined
      parentId: 1
    }
