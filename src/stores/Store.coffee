EventEmitter = require('events').EventEmitter
_ = require 'lodash'

Dispatcher = require '../dispatcher/Dispatcher.coffee'
Constants = require '../constants/Constants.coffee'

CHANGE_EVENT = 'change'


_items = []

update = (item) ->
  _items = [item]
  Store.emitChange()


Store = _.assign {}, EventEmitter.prototype,
  getItems: ->
    _(_items)
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
    when Constants.api.GET_ITEM
      update(payload.item)


module.exports = Store
