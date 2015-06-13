React = require 'react'
_ = require 'lodash'
Store = require '../stores/Store.coffee'
List = require './List.coffee'

getItems = ->
  items: Store.getItems()

Main = React.createClass
  getInitialState: ->
    getItems()

  componentDidMount: ->
    Store.addChangeListener(@._onChange)

  componentWillUnmount: ->
    Store.removeChangeListener(@._onChange)

  render: ->
    React.createElement(List, {items: @state.items})

  _onChange: ->
    @setState(getItems())


module.exports = Main
