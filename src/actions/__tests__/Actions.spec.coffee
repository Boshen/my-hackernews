jest.dontMock '../Actions.coffee'
jest.dontMock '../../constants/Constants.coffee'

describe 'Actions', ->
  Dispatcher = Constants = HackerNewsApi = Actions = null

  beforeEach ->
    Dispatcher = require '../../dispatcher/Dispatcher.coffee'
    Constants = require '../../constants/Constants.coffee'
    HackerNewsApi = require '../../utils/HackerNewsApi.coffee'
    Actions = require '../Actions.coffee'

  describe 'create item', ->
    it 'should create an item and dispatch it', ->
      item = {id: 1}
      Actions.createItem(item)
      expect(Dispatcher.dispatch).toBeCalledWith {
        type: Constants.CREATE_ITEM
        item: item
      }

  describe 'click comments', ->
    pit 'should fetch all comments', ->
      Q = require 'q'

      ids = [1, 2, 3]
      comments = [ {id: 100, kids: [1]}, {id: 101, kids: [2]}, {id: 102, kids: [3]} ]

      HackerNewsApi.get.mockImplementation (id, i)->
        Q.when comments[i]

      Q.when()
      # TODO:
      # How do I test this?
      # starting with `pit` and then what?

      #Actions.clickComments(ids)
        #.then ->
          #expect(HackerNewsApi.get.mock.calls.length).toBe ids.length
          #HackerNewsApi.get.mock.calls.forEach (call, i)->
            #expect(call[0]).toBe ids[i]

          #expect(Dispatcher.dispatch.mock.calls.length).toBe ids.length
          #Dispatcher.dispatcher.mock.calls.forEach (call, i)->
            #expect(call).toEqual {
              #type: Constants.CREATE_COMMENT
              #comment: comments[i]
            #}
