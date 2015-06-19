EventEmitter = require('events').EventEmitter
Immutable = require('immutable')
_ = require 'lodash'

Dispatcher = require '../dispatcher/Dispatcher.coffee'
Constants = require '../constants/Constants.coffee'

CHANGE_EVENT = 'change'

_items = new Immutable.Map()
_comments = new Immutable.Map()

updateItem = (item) ->
  _items = _items.set(item.id, new Immutable.Map(item))

updateComments = (comments) ->
  comments.forEach (comment) ->
    if not _comments.has(comment.parent)
      _comments = _comments.set(comment.parent, new Immutable.List())
    newCommentList = _comments.get(comment.parent).push(new Immutable.Map(comment))
    _comments = _comments.set(comment.parent, newCommentList)

deleteComments = (id) ->
  if _comments.has(id)
    _comments.get(id).forEach (comment) ->
      deleteComments(comment.get('id'))
  _comments = _comments.delete(id)

Store = _.assign {}, EventEmitter.prototype,
  getItems: ->
    _items.toList().sort (itemA, itemB) ->
      a = itemA.get('descendants') * itemA.get('score')
      b = itemB.get('descendants') * itemB.get('score')
      b - a

  getComments: ->
    _comments

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

    when Constants.CREATE_COMMENTS
      updateComments(payload.comments)
      Store.emitChange()

    when Constants.DELETE_COMMENTS
      deleteComments(payload.id)
      Store.emitChange()

module.exports = Store
