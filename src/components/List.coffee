React = require 'react'
PureRenderMixin = require('react/addons').addons.PureRenderMixin
Immutable = require('immutable')
_ = require 'lodash'

ListItem = require './ListItem.coffee'

List = React.createClass
  mixins: [PureRenderMixin]

  propTypes:
    items: React.PropTypes.instanceOf(Immutable.List).isRequired

  render: ->
    React.createElement 'ol', null, @props.items.map (item) ->
      React.createElement ListItem, {key: item.get('id'), item: item}, null

module.exports = List
