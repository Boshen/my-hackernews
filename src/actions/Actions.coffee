Dispatcher = require '../dispatcher/Dispatcher.coffee'
Constants = require '../constants/Constants.coffee'
HackerNewsApi = require '../utils/HackerNewsApi.coffee'

Actions =
  receiveItem: (item)->
    Dispatcher.dispatch {
      type: Constants.api.GET_ITEM
      item: item
    }

module.exports = Actions
