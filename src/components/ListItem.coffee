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

    React.createElement 'li', null,
      React.createElement 'div', {className: 'title'},
        React.createElement 'span', null,
          React.createElement 'a', {href: item.get('url')}, item.get('title')
        React.createElement 'span', {onClick: @_clickComments}, item.get('descendants')
      React.createElement Comments, {comments: @props.comments, parentId: item.get('id')}

  _clickComments: ->
    Actions.clickComments @props.item.get('kids')

module.exports = ListItem
