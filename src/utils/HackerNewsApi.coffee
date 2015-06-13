Firebase = require 'firebase'

Actions = require '../actions/Actions.coffee'

api = new Firebase('https://hacker-news.firebaseio.com/v0')

firebaseRef = null

module.exports =
  init: ->
    if not firebaseRef?
      firebaseRef = api.child('topstories').limitToFirst(10)
    @getItems()

  getItems: ->
    firebaseRef.on 'value', (snapshot) ->
      console.log 'getItems', snapshot.val()
      Actions.receiveIds snapshot.val()

  getItem: (id)->
    api.child('item/' + id).once 'value', (snapshot) ->
      Actions.receiveItem snapshot.val()

