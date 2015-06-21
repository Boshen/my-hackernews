React = require 'react'
PureRenderMixin = require('react/addons').addons.PureRenderMixin
Immutable = require 'immutable'
Link = require('react-router').Link


Actions = require '../actions/Actions.coffee'

ListItem = React.createClass
  mixins: [PureRenderMixin]

  propTypes:
    item: React.PropTypes.instanceOf(Immutable.Map).isRequired

  render: ->
    item = @props.item

    descendants = item.get('descendants')
    commentButton = if descendants > 0
      React.createElement Link, {to: 'story', params: {id: item.get('id')}},
        React.createElement 'button', {className: 'btn-comment'}, descendants
    else
      null

    React.createElement 'li', null,
      React.createElement 'div', {className: 'title'},
        React.createElement 'span', null,
          React.createElement 'a', {href: item.get('url')}, item.get('title')
        React.createElement 'span', null, commentButton

module.exports = ListItem
