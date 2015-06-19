React = require 'react'
Store = require '../stores/Store.coffee'
List = require './List.coffee'

getStates = ->
  items: Store.getItems()
  comments: Store.getComments()

Main = React.createClass
  getInitialState: ->
    getStates()

  componentDidMount: ->
    Store.addChangeListener @_onChange

  componentWillUnmount: ->
    Store.removeChangeListener @_onChange

  render: ->
    React.createElement List, {items: @state.items, comments: @state.comments}

  _onChange: ->
    @setState getStates()

module.exports = Main
