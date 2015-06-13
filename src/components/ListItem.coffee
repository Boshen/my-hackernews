React = require 'react'

ListItem = React.createClass

  propTypes:
    item: React.PropTypes.object.isRequired

  render: ->
    item = @props.item

    comments = if item.kids then item.kids.length else 0

    React.createElement 'li', null,
      React.createElement 'span', null, comments
      React.createElement 'span', null, item.score
      React.createElement 'a', {href: item.url}, item.title


module.exports = ListItem
