jest.dontMock '../List.coffee'

describe 'List', ->
  Immutable = require 'immutable'

  React = require 'react/addons'
  TestUtils = React.addons.TestUtils
  List = ListItem = null

  element = items = null

  beforeEach ->
    List = require '../List.coffee'
    ListItem = require '../ListItem.coffee'

    items = new Immutable.List [
      new Immutable.Map {id: 1}
      new Immutable.Map {id: 2}
    ]
    element = TestUtils.renderIntoDocument React.createElement(List, {items: items})

  it 'should exists', ->
    expect(TestUtils.isCompositeComponent(element)).toBeTruthy()

  it 'should create a list', ->
    ol = TestUtils.findRenderedDOMComponentWithTag element, 'ol'
    expect(ol.getDOMNode().children.length).toBe 2
    expect(ListItem.mock.calls.length).toEqual 2
    ListItem.mock.calls.forEach (call, i) ->
      expect(call[0].item.equals(items.get(i))).toBeTruthy()
