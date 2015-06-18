_ = require 'lodash'
Q = require 'q'

Dispatcher = require '../dispatcher/Dispatcher.coffee'
Constants = require '../constants/Constants.coffee'
HackerNewsApi = require '../utils/HackerNewsApi.coffee'

Actions =
  init: ->
    cb = (id) ->
      HackerNewsApi.get id
        .then (item) ->
          Actions.createItem item

    HackerNewsApi.getTopStories cb
    HackerNewsApi.getNewStories cb

  createItem: (item) ->
    Dispatcher.dispatch {
      type: Constants.CREATE_ITEM
      item: item
    }

  clickComments: (ids) ->
    promises = _.map ids, (id) ->
      HackerNewsApi.get id

    Q.all promises
      .then (items) ->
        _.each items, (item) ->
          Dispatcher.dispatch {
            type: Constants.CREATE_ITEM
            item: item
          }
          if item.kids?
            Actions.clickComments(item.kids)
      .done()

module.exports = Actions
