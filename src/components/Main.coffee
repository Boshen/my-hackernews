React = require 'react'
_ = require 'lodash'
Store = require '../stores/Store.coffee'

getItems = ->
  items: Store.getItems()

Main = React.createClass
  getInitialState: ->
    getItems()

  componentWillMount: ->
    Store.start()

  componentDidMount: ->
    Store.addChangeListener(@._onChange)

  componentWillUnmount: ->
    Store.removeChangeListener(@._onChange)


  render: ->
    items = _.mapValues @state.items, (id) ->
      React.createElement('li', null, id)

    React.createElement('ul', null, items)

  _onChange: ->
    @setState(getItems())


module.exports = Main
