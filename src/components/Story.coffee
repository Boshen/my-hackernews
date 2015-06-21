React = require 'react'
Comments = require './Comments.coffee'
Store = require '../stores/Store.coffee'
Actions = require '../actions/Actions.coffee'

getStates = ->
  comments: Store.getComments()

Story = React.createClass
  getInitialState: ->
    states = getStates()
    states.id = Number(@props.params.id)
    states

  componentDidMount: ->
    Actions.clickComments(Store.getItem(@states.id).get('kids'))
    Store.addChangeListener @_onChange

  componentWillUnmount: ->
    Store.removeChangeListener @_onChange

  render: ->
    React.createElement Comments, {comments: @state.comments, parentId: @states.id}

  _onChange: ->
    @setState getStates()


module.exports = Story
