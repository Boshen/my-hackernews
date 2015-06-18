React = require 'react'
PureRenderMixin = require('react/addons').addons.PureRenderMixin
Immutable = require 'immutable'

ListItem = require './ListItem.coffee'

List = React.createClass
  mixins: [PureRenderMixin]

  propTypes:
    items: React.PropTypes.instanceOf(Immutable.List).isRequired
    comments: React.PropTypes.instanceOf(Immutable.Map)

  render: ->
    React.createElement 'ol', null, @props.items.map (item) =>
      React.createElement ListItem, {key: item.get('id'), item: item, comments: @props.comments}, null

module.exports = List
