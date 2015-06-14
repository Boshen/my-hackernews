Firebase = require 'firebase'

Actions = require '../actions/Actions.coffee'

api = new Firebase('https://hacker-news.firebaseio.com/v0')

HackerNewsApi =
  init: ->
    @getAll api.child('topstories').limitToFirst(50)
    @getAll api.child('newstories').limitToFirst(10)

  getAll: (ref)->
    ref.on 'child_changed', (snapshot) =>
      @get snapshot.val()

    ref.on 'child_added', (snapshot) =>
      @get snapshot.val()

  get: (id)->
    api.child('item/' + id).once 'value', (snapshot) ->
      item = snapshot.val()
      Actions.createItem item if item

module.exports = HackerNewsApi
