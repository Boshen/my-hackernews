React = require 'react'
PureRenderMixin = require('react/addons').addons.PureRenderMixin
Immutable = require 'immutable'

ListItem = React.createFactory require './ListItem.coffee'

ol = React.DOM.ol

List = React.createClass
  mixins: [PureRenderMixin]

  propTypes:
    items: React.PropTypes.instanceOf(Immutable.List).isRequired
    comments: React.PropTypes.instanceOf(Immutable.Map)

  render: ->
    ol null, @props.items.map (item) =>
      ListItem {key: item.get('id'), item: item, comments: @props.comments}

module.exports = List
