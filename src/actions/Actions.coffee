Dispatcher = require '../dispatcher/Dispatcher.coffee'
Constants = require '../constants/Constants.coffee'

Actions =
  createItem: (item) ->
    Dispatcher.dispatch {
      type: Constants.CREATE_ITEM
      item: item
    }

module.exports = Actions
