jest.dontMock '../Store.coffee'
jest.dontMock '../../constants/Constants.coffee'

describe 'Store', ->
  Immutable = require 'immutable'

  Constants = require '../../constants/Constants.coffee'
  Dispatcher = null
  Store = null

  callback = null
  createComments = null
  deleteComments = null

  beforeEach ->
    Dispatcher = require '../../dispatcher/Dispatcher.coffee'
    Store = require '../Store.coffee'
    callback = Dispatcher.register.mock.calls[0][0]

    createComments = (comments) ->
      callback {
        type: Constants.CREATE_COMMENTS
        comments: comments
      }

    deleteComments = (id) ->
      callback {
        type: Constants.DELETE_COMMENTS
        id: id
      }

  describe 'CREATE_ITEM', ->
    createItem = null

    beforeEach ->
      createItem = (item) ->
        callback {
          type: Constants.CREATE_ITEM
          item: item
        }

    it 'should register a callback with the dispatcher', ->
      expect(Dispatcher.register.mock.calls.length).toBe 1

    it 'should initialize with no items', ->
      items = Store.getItems()
      expect(Immutable.List.isList(items)).toBeTruthy()
      expect(items.size).toBe 0

    it 'should create an item', ->
      item = id: 1

      createItem(item)
      items = Store.getItems()
      expect(Immutable.Map.isMap(items.first())).toBeTruthy()
      expect(items.first().toJS()).toEqual item

    it 'should update the item if it already exists', ->
      item1 = id: 1, score: 0
      item2 = id: 1, score: 1

      createItem(item1)
      items = Store.getItems().toJS()
      expect(items[0]).toEqual item1

      createItem(item2)
      items = Store.getItems().toJS()
      expect(items[0]).toEqual item2

    it 'should add multiple items and sort descendant by descendants * scores', ->
      item1 = id: 1, score: 1, descendants: 2
      item2 = id: 2, score: 2, descendants: 3
      item3 = id: 3, score: 3, descendants: 1
      item4 = id: 4, score: 4, descendants: 0

      createItem(item1)
      items = Store.getItems().toJS()
      expect(items).toEqual [item1]

      createItem(item2)
      items = Store.getItems().toJS()
      expect(items).toEqual [item2, item1]

      createItem(item3)
      items = Store.getItems().toJS()
      expect(items).toEqual [item2, item3, item1]

      createItem(item4)
      items = Store.getItems().toJS()
      expect(items).toEqual [item2, item3, item1, item4]

  describe 'CREATE_COMMENTS', ->
    it 'should add comments', ->
      item1 = id: 2, parent: 1
      item2 = id: 3, parent: 1
      item3 = id: 4, parent: 3

      comments = [item1, item2, item3]
      createComments(comments)

      expect(Store.getComments().toJS()).toEqual {
        1: [item1, item2]
        3: [item3]
      }

  describe 'DELETE_COMMENTS', ->
    it 'should delete comments and all its children', ->
      createComments [
        {id: 2, parent: 1}
        {id: 10, parent: 2}
        {id: 11, parent: 2}
        {id: 20, parent: 21}
      ]

      deleteComments(1)

      expect(Store.getComments().toJS()).toEqual {
        21: [{id: 20, parent: 21}]
      }
