Dispatcher = require '../dispatcher/Dispatcher.coffee'
Constants = require '../constants/Constants.coffee'

Actions =
  receiveIds: (ids)->
    Dispatcher.dispatch {
      type: Constants.api.GET_IDS
      ids: ids
    }

  receiveItem: (item)->
    Dispatcher.dispatch {
      type: Constants.api.GET_ITEM
      item: item
    }

module.exports = Actions
