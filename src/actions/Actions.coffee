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
  getTopStories: ->
    HackerNewsApi.getTopStories()
      .then (stories) ->
        _.each stories, (storyId) ->
          HackerNewsApi.get storyId
            .then (item) ->
              Actions.createItem item

  createItem: (item) ->
    Dispatcher.dispatch {
      type: Constants.CREATE_ITEM
      item: item
    }

  clickComments: (itemOrId) ->
    promise =
      if _.isNumber(itemOrId)
        HackerNewsApi.get(itemOrId)
          .then (item) ->
            Dispatcher.dispatch {
              type: Constants.CREATE_ITEM
              item: item
            }
            Q.when(item)
      else
        Q.when(itemOrId)

    promise.then (item) ->
      comments = []
      ids = item.kids or item.get('kids')
      getComments(ids, comments)
        .then ->
          Dispatcher.dispatch {
            type: Constants.CREATE_COMMENTS
            comments: comments
          }

  deleteComments: ->
    Dispatcher.dispatch {
      type: Constants.DELETE_COMMENTS
    }

module.exports = Actions
