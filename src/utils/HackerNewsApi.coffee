Firebase = require 'firebase'
Q = require 'q'

api = new Firebase 'https://hacker-news.firebaseio.com/v0'

HackerNewsApi =
  getTopStories: ->
    deferred = Q.defer()
    api.child('topstories').limitToFirst(10).once 'value', (snapshot) ->
      item = snapshot.val()
      if item
        deferred.resolve item
      else
        deferred.reject()
    deferred.promise

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
