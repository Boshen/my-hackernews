React = require 'react'
StoryStore = require '../stores/StoryStore.coffee'
Actions = require '../actions/Actions.coffee'
List = React.createFactory require '../components/List.coffee'

getStates = ->
  items: StoryStore.getItems()

Main = React.createClass
  getInitialState: ->
    getStates()

  componentDidMount: ->
    Actions.getTopStories()
    StoryStore.addChangeListener @_onChange

  componentWillUnmount: ->
    StoryStore.removeChangeListener @_onChange

  render: ->
    List items: @state.items

  _onChange: ->
    @setState getStates()

module.exports = Main
