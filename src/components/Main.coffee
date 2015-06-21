React = require 'react'
Store = require '../stores/Store.coffee'
List = require './List.coffee'
Actions = require '../actions/Actions.coffee'

getStates = ->
  items: Store.getItems()

Main = React.createClass
  getInitialState: ->
    getStates()

  componentDidMount: ->
    Actions.getTopStories()
    Store.addChangeListener @_onChange

  componentWillUnmount: ->
    Store.removeChangeListener @_onChange

  render: ->
    React.createElement List, {items: @state.items}

  _onChange: ->
    @setState getStates()

module.exports = Main
