React = require 'react'
PureRenderMixin = require('react/addons').addons.PureRenderMixin
Immutable = require 'immutable'

Actions = require '../actions/Actions.coffee'

ListItem = React.createClass
  mixins: [PureRenderMixin]

  propTypes:
    item: React.PropTypes.instanceOf(Immutable.Map).isRequired

  render: ->
    item = @props.item

    React.createElement 'li', null,
      React.createElement 'span', null,
        React.createElement 'a', {href: item.get('url')}, item.get('title')
      React.createElement 'span', {onClick: @_clickComments}, item.get('descendants')

  _clickComments: ->
    Actions.clickComments @props.item.get('kids')

module.exports = ListItem
