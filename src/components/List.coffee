React = require 'react'
_ = require 'lodash'

List = React.createClass
  propTypes:
    items: React.PropTypes.array.isRequired

  render: ->
    console.log 'render list', @props
    items = _.mapValues @props.items, (item) ->
      React.createElement('li', null, item.kids?.length + ' ' + item.score + ' ' + item.title)

    React.createElement('ul', null, items)

module.exports = List
