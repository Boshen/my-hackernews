EventEmitter = require('events').EventEmitter
Immutable = require('immutable')
_ = require 'lodash'

Dispatcher = require '../dispatcher/Dispatcher.coffee'
Constants = require '../constants/Constants.coffee'

CHANGE_EVENT = 'change_comment'

_comments = new Immutable.Map()

updateComments = (comments) ->
  comments.forEach (comment) ->
    if not _comments.has(comment.parent)
      _comments = _comments.set(comment.parent, new Immutable.List())
    newCommentList = _comments.get(comment.parent).push(new Immutable.Map(comment))
    _comments = _comments.set(comment.parent, newCommentList)

deleteComments = ->
  _comments = _comments.clear()

CommentStore = _.assign {}, EventEmitter.prototype,
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

    when Constants.CREATE_COMMENTS
      updateComments(payload.comments)
      CommentStore.emitChange()

    when Constants.DELETE_COMMENTS
      deleteComments()
      CommentStore.emitChange()

module.exports = CommentStore
