React = require 'react'
PureRenderMixin = require('react/addons').addons.PureRenderMixin
Immutable = require 'immutable'

Actions = require '../actions/Actions.coffee'
Comments = require './Comments.coffee'

ListItem = React.createClass
  mixins: [PureRenderMixin]

  propTypes:
    item: React.PropTypes.instanceOf(Immutable.Map).isRequired
    comments: React.PropTypes.instanceOf(Immutable.Map)

  render: ->
    item = @props.item

    descendants = item.get('descendants')
    commentButton = if descendants > 0
      React.createElement 'button', {className: 'btn-comment', onClick: @_clickComments}, descendants
    else
      null

    React.createElement 'li', null,
      React.createElement 'div', {className: 'title'},
        React.createElement 'span', null,
          React.createElement 'a', {href: item.get('url')}, item.get('title')
        React.createElement 'span', null, commentButton
      React.createElement Comments, {comments: @props.comments, parentId: item.get('id')}

  _clickComments: ->
    if @props.comments and @props.comments.get(@props.item.get('id'))
      Actions.deleteComments @props.item.get('id')
    else
      Actions.clickComments @props.item.get('kids')

module.exports = ListItem
