React = require 'react'
CommentStore = require '../stores/CommentStore.coffee'
StoryStore = require '../stores/StoryStore.coffee'
Actions = require '../actions/Actions.coffee'
Comments = require '../components/Comments.coffee'

getStates = ->
  comments: CommentStore.getComments()

Story = React.createClass
  getInitialState: ->
    states = getStates()
    states.id = Number(@props.params.id)
    states

  componentDidMount: ->
    Actions.clickComments(StoryStore.getItem(@state.id).get('kids'))
    CommentStore.addChangeListener @_onChange

  componentWillUnmount: ->
    CommentStore.removeChangeListener @_onChange

  render: ->
    React.createElement Comments, {comments: @state.comments, parentId: @state.id, depth: 0}

  _onChange: ->
    @setState getStates()


module.exports = Story
