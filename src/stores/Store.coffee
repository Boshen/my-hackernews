EventEmitter = require('events').EventEmitter
Immutable = require('immutable')
_ = require 'lodash'

Dispatcher = require '../dispatcher/Dispatcher.coffee'
Constants = require '../constants/Constants.coffee'

CHANGE_EVENT = 'change'

_items = new Immutable.Map()

updateItem = (item) ->
  _items = _items.set(item.id, new Immutable.Map(item))

Store = _.assign {}, EventEmitter.prototype,
  getItems: ->
    _items.toList().sort (itemA, itemB) ->
      a = itemA.get('descendants') * itemA.get('score')
      b = itemB.get('descendants') * itemB.get('score')
      b - a

  emitChange: ->
    @emit(CHANGE_EVENT)

  addChangeListener: (callback) ->
    @on(CHANGE_EVENT, callback)

  removeChangeListener: (callback) ->
    @removeListener(CHANGE_EVENT, callback)

Dispatcher.register (payload) ->
  switch payload.type

    when Constants.CREATE_ITEM
      updateItem(payload.item)
      Store.emitChange()

module.exports = Store
