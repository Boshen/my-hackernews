Dispatcher = require '../dispatcher/Dispatcher.coffee'
EventEmitter = require('events').EventEmitter
_ = require 'lodash'
Firebase = require 'firebase'

api = new Firebase('https://hacker-news.firebaseio.com/v0')

firebaseRef = null

CHANGE_EVENT = 'change'

_items = []

update = (snapshot) ->
  _items = _.values(snapshot.exportVal())
  Store.emitChange()

Store = _.assign {}, EventEmitter.prototype,
  getItems: ->
    _items

  start: ->
    if not firebaseRef?
      firebaseRef = api.child('topstories')
      firebaseRef.on('value', update)

  emitChange: ->
    @emit(CHANGE_EVENT)

  addChangeListener: (callback) ->
    @on(CHANGE_EVENT, callback)

  removeChangeListener: (callback) ->
    @removeListener(CHANGE_EVENT, callback)


Dispatcher.register (action) ->
  return

module.exports = Store
