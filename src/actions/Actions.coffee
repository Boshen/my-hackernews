_ = require 'lodash'
Q = require 'q'

Dispatcher = require '../dispatcher/Dispatcher.coffee'
Constants = require '../constants/Constants.coffee'
HackerNewsApi = require '../utils/HackerNewsApi.coffee'

getComments = (ids, comments) ->
  Q.all _.map ids, (id) ->
    HackerNewsApi.get id
      .then (item) ->
        comments.push(item)
        if item.kids?
          getComments(item.kids, comments)
        else
          Q.when()

Actions =
  init: ->
    cb = (id) ->
      HackerNewsApi.get id
        .then (item) ->
          Actions.createItem item

    HackerNewsApi.getTopStories cb
    #HackerNewsApi.getNewStories cb

  createItem: (item) ->
    Dispatcher.dispatch {
      type: Constants.CREATE_ITEM
      item: item
    }

  clickComments: (ids) ->
    comments = []
    getComments(ids, comments)
      .then ->
        Dispatcher.dispatch {
          type: Constants.CREATE_COMMENTS
          comments: comments
        }
      .done()

  deleteComments: (id) ->
    Dispatcher.dispatch {
      type: Constants.DELETE_COMMENTS
      id: id
    }

module.exports = Actions
