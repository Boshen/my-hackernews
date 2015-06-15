Firebase = require 'firebase'
Q = require 'q'

api = new Firebase 'https://hacker-news.firebaseio.com/v0'

HackerNewsApi =
  getTopStories: (cb) ->
    @getRef api.child('topstories').limitToFirst(50), cb

  getNewStories: (cb) ->
    @getRef api.child('newstories').limitToFirst(10), cb

  getRef: (ref, cb) ->
    ref.on 'child_changed', (snapshot) =>
      cb snapshot.val()

    ref.on 'child_added', (snapshot) =>
      cb snapshot.val()

  get: (id) ->
    deferred = Q.defer()
    api.child('item/' + id).once 'value', (snapshot) ->
      item = snapshot.val()
      if item
        deferred.resolve item
      else
        deferred.reject()
    deferred.promise

module.exports = HackerNewsApi
