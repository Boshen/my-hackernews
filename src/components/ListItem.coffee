React = require 'react'
PureRenderMixin = require('react/addons').addons.PureRenderMixin

ListItem = React.createClass
  mixins: [PureRenderMixin]

  propTypes:
    item: React.PropTypes.object.isRequired

  render: ->
    item = @props.item

    React.createElement 'li', null,
      React.createElement 'span', null, item.descendants
      React.createElement 'span', null, item.score
      React.createElement 'span', null,
        React.createElement 'a', {href: item.url}, item.title


module.exports = ListItem
