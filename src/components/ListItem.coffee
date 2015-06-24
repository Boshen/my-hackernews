React = require 'react'
PureRenderMixin = require('react/addons').addons.PureRenderMixin
Immutable = require 'immutable'
Link = require('react-router').Link

Actions = require '../actions/Actions.coffee'

[li, div, span, a] = ['li', 'div', 'span', 'a'].map((_) -> React.DOM[_])

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

    li null,
      div className: 'title',
        span null,
          a href: item.get('url'), item.get('title')
        span null, commentButton

module.exports = ListItem
