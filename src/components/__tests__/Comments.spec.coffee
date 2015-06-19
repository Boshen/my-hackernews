jest.dontMock '../Comments.coffee'

describe 'Comments', ->

  React = require 'react/addons'
  Immutable = require 'immutable'
  TestUtils = React.addons.TestUtils
  Comments = null

  beforeEach ->
    Comments = require '../Comments.coffee'

  it 'should exists', ->
    element = TestUtils.renderIntoDocument React.createElement(Comments, {parentId: 1})
    expect(TestUtils.isCompositeComponent(element)).toBeTruthy()

  it 'should not render if there are no comments', ->
    element = TestUtils.renderIntoDocument React.createElement(Comments, {parentId: 1})
    expect(React.findDOMNode(element)).toBeNull()

  it 'should not render comments if there are no comments for parent id', ->
    parentId = 1
    commentsJS = {}
    commentsJS[2] = [{text: 'test'}]
    comments = Immutable.fromJS commentsJS

    element = TestUtils.renderIntoDocument React.createElement(Comments, {comments: comments, parentId: parentId})
    expect(React.findDOMNode(element)).toBeNull()

  it 'should render comments if there are comments for parent id', ->
    parentId = 1
    comments = new Immutable.Map()
    comments = comments.set(parentId, Immutable.fromJS([{id: 2, text: 'test'}]))

    element = TestUtils.renderIntoDocument React.createElement(Comments, {comments: comments, parentId: parentId})
    expect(React.findDOMNode(element)).toBeDefined()

    comment = TestUtils.findRenderedDOMComponentWithClass(element, 'comment')
    expect(React.findDOMNode(element).textContent).toBe 'test'

  it 'should render child comments', ->
    parentId = 1
    childId = 2
    comments = new Immutable.Map()
    comments = comments.set(parentId, Immutable.fromJS([{id: 2, text: 'test 1'}]))
    comments = comments.set(childId, Immutable.fromJS([{id: 3, text: 'test 2'}]))

    element = TestUtils.renderIntoDocument React.createElement(Comments, {comments: comments, parentId: parentId})
    expect(React.findDOMNode(element)).toBeDefined()

    allComments = TestUtils.scryRenderedDOMComponentsWithClass(element, 'comment')
    expect(allComments.length).toBe 2
    allComments.forEach (comment, i) ->
      expect(React.findDOMNode(comment).textContent).toBe 'test ' + (i + 1)
