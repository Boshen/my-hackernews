React = require 'react'
PureRenderMixin = require('react/addons').addons.PureRenderMixin

ListItem = React.createClass
  mixins: [PureRenderMixin]

  propTypes:
    item: React.PropTypes.object.isRequired

  render: ->
    item = @props.item

    React.createElement 'li', null,
      React.createElement 'span', null, item.get('descendants')
      React.createElement 'span', null, item.get('score')
      React.createElement 'span', null,
        React.createElement 'a', {href: item.get('url')}, item.get('title')

module.exports = ListItem
