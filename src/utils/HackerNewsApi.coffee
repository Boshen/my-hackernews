Firebase = require 'firebase'
Q = require 'q'

api = null

init = ->
  api = new Firebase 'https://hacker-news.firebaseio.com/v0'

HackerNewsApi =
  getTopStories: ->
    init() if not api

    deferred = Q.defer()
    api.child('topstories').limitToFirst(10).once 'value', (snapshot) ->
      item = snapshot.val()
      if item
        deferred.resolve item
      else
        deferred.reject()
    deferred.promise

  get: (id) ->
    init() if not api

    deferred = Q.defer()
    api.child('item/' + id).once 'value', (snapshot) ->
      item = snapshot.val()
      if item
        deferred.resolve item
      else
        deferred.reject()
    deferred.promise

module.exports = HackerNewsApi
