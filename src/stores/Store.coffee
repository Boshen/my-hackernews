EventEmitter = require('events').EventEmitter
Immutable = require('immutable')
_ = require 'lodash'

Dispatcher = require '../dispatcher/Dispatcher.coffee'
Constants = require '../constants/Constants.coffee'

CHANGE_EVENT = 'change'

_items = new Immutable.Map()
_comments = new Immutable.Map()

updateItem = (item) ->
  if item.parent
    if not _comments.get(item.parent)
      _comments = _comments.set(item.parent, new Immutable.List())
      newCommentList = _comments.get(item.parent).push(item)
      _comments = _comments.set(item.parent, newCommentList)
  else
    _items = _items.set(item.id, new Immutable.Map(item))

Store = _.assign {}, EventEmitter.prototype,
  getItems: ->
    _items.toList().sort (itemA, itemB) ->
      a = itemA.get('descendants') * itemA.get('score')
      b = itemB.get('descendants') * itemB.get('score')
      b - a

  getComments: (id) ->
    _comments.get(id)

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
