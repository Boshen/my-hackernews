Firebase = require 'firebase'

Actions = require '../actions/Actions.coffee'

api = new Firebase('https://hacker-news.firebaseio.com/v0')

firebaseRef = null


module.exports =

  init: ->
    @getItems()
    #if not firebaseRef?
      #firebaseRef = api.child('topstories').limitToFirst(10)
      #firebaseRef.once 'value', (snapshot) ->
        #snapshot.forEach (idRef) ->
          #id = idRef.val()
          #api.child('item/' + id).once 'value', (itemSnapShot) ->
          #Actions.receiveItem itemSnapShot.val()

  getItems: ->
    Actions.receiveItem {
      by: "skbohra123"
      descendants: 4
      id: 9710070
      kids: [{}, {}, {}]
      score: 73
      text: ""
      time: 1434175481
      title: "How to Make Almost Anything"
      type: "story"
      url: "http://fab.cba.mit.edu/classes/MIT/863.09/"
    }
