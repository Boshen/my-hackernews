React = require 'react'
PureRenderMixin = require('react/addons').addons.PureRenderMixin
List = require('immutable').List
_ = require 'lodash'

List = React.createClass
  mixins: [PureRenderMixin]

  propTypes:
    items: React.PropTypes.instanceOf(List).isRequired

  render: ->
    items = @props.items.map (item) ->
      comments = if item.kids then item.kids.length else 0
      React.createElement('li', {key: item.id}, comments + ' ' + item.score + ' ' + item.title)

    React.createElement('ul', null, items)

module.exports = List
