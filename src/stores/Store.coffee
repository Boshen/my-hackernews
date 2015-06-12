Dispatcher = require '../dispatcher/Dispatcher.coffee'
EventEmitter = require('events').EventEmitter
_ = require 'lodash'
Firebase = require 'firebase'

api = new Firebase('https://hacker-news.firebaseio.com/v0')

firebaseRef = null

CHANGE_EVENT = 'change'

_items = []

update = (snapshot) ->
  snapshot.forEach (idRef) ->
    id = idRef.val()
    console.log id
    api.child('item/' + id).once 'value', (itemSnapShot) ->
      _items.push itemSnapShot.val()
      Store.emitChange()



Store = _.assign {}, EventEmitter.prototype,
  getItems: ->
    console.log _items
    _(_items)
      .sortBy (item) ->
        if item.kids then -item.kids.length else 0
      .value()

  start: ->
    if not firebaseRef?
      firebaseRef = api.child('topstories').limitToFirst(10)
      firebaseRef.once('value', update)

  emitChange: ->
    @emit(CHANGE_EVENT)

  addChangeListener: (callback) ->
    @on(CHANGE_EVENT, callback)

  removeChangeListener: (callback) ->
    @removeListener(CHANGE_EVENT, callback)


Dispatcher.register (action) ->
  return

module.exports = Store
