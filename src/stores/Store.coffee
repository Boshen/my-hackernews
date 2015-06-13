EventEmitter = require('events').EventEmitter
_ = require 'lodash'

Dispatcher = require '../dispatcher/Dispatcher.coffee'
Constants = require '../constants/Constants.coffee'
HackerNewsApi = require '../utils/HackerNewsApi.coffee'

CHANGE_EVENT = 'change'

_ids = []
_items = {}

updateIds = (ids) ->
  idsToUpdate = []
  if _ids.length is 0
    _ids = ids
    idsToUpdate = idsToUpdate.concat(ids)
  else
    _.each ids, (id, idx) ->
      if _ids[idx] isnt id
        idsToUpdate = idsToUpdate.concat(id)

  _.each idsToUpdate, (id)->
    HackerNewsApi.getItem(id)

updateItem = (item) ->
  _items[item.id] = item


Store = _.assign {}, EventEmitter.prototype,
  getItems: ->
    _(_items)
      .toArray()
      .sortBy (item) ->
        if item.kids then -item.kids.length else 0
      .value()

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
