EventEmitter = require('events').EventEmitter
Map = require('immutable').Map
_ = require 'lodash'

Dispatcher = require '../dispatcher/Dispatcher.coffee'
Constants = require '../constants/Constants.coffee'
HackerNewsApi = require '../utils/HackerNewsApi.coffee'

CHANGE_EVENT = 'change'

_items = new Map()

updateIds = (ids) ->
  _.each ids, (id) ->
    HackerNewsApi.getItem(id)

updateItem = (item) ->
  _items = _items.set item.id, item


Store = _.assign {}, EventEmitter.prototype,
  getItems: ->
    _items.toList().sort (itemA, itemB) ->
      if not itemA.kids or not itemB.kids or itemA.kids.length == itemB.kids.length
        0
      else if itemA.kids.length < itemB.kids.length
        1
      else
        -1

  emitChange: ->
    @emit(CHANGE_EVENT)

  addChangeListener: (callback) ->
    @on(CHANGE_EVENT, callback)

  removeChangeListener: (callback) ->
    @removeListener(CHANGE_EVENT, callback)


Dispatcher.register (payload) ->
  switch payload.type

    when Constants.api.GET_IDS
      updateIds(payload.ids)
      #Store.emitChange()

    when Constants.api.GET_ITEM
      updateItem(payload.item)
      Store.emitChange()


module.exports = Store
