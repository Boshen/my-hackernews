jest.dontMock '../Actions.coffee'
jest.dontMock '../../constants/Constants.coffee'

describe 'Actions', ->
  Dispatcher = require '../../dispatcher/Dispatcher.coffee'
  Constants = require '../../constants/Constants.coffee'
  Actions = require '../Actions.coffee'

  it 'should create an item and dispatch it', ->
    item = {id: 1}
    Actions.createItem(item)
    expect(Dispatcher.dispatch).toBeCalledWith {
      type: Constants.CREATE_ITEM
      item: item
    }
