Firebase = require 'firebase'

Actions = require '../actions/Actions.coffee'

api = new Firebase('https://hacker-news.firebaseio.com/v0')

firebaseRef = null

HackerNewsApi =
  init: ->
    if not firebaseRef?
      firebaseRef = api.child('topstories').limitToFirst(10)
    @getIds()

  getIds: ->
    firebaseRef.on 'value', (snapshot) ->
      ids = snapshot.val()
      console.log 'update ids', ids
      ids.forEach (id)->
        HackerNewsApi.getItem(id)

  getItem: (id)->
    api.child('item/' + id).once 'value', (snapshot) ->
      Actions.receiveItem snapshot.val()


module.exports = HackerNewsApi
