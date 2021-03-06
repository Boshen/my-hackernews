React = require 'react'
CommentStore = require '../stores/CommentStore.coffee'
StoryStore = require '../stores/StoryStore.coffee'
Actions = require '../actions/Actions.coffee'
Comments = React.createFactory require '../components/Comments.coffee'

getStates = ->
  comments: CommentStore.getComments()

Story = React.createClass
  getInitialState: ->
    states = getStates()
    states.id = Number(@props.params.id)
    states

  componentDidMount: ->
    Actions.clickComments(StoryStore.getItem(@state.id))
    CommentStore.addChangeListener @_onChange

  componentWillUnmount: ->
    Actions.deleteComments()
    CommentStore.removeChangeListener @_onChange

  render: ->
    Comments {comments: @state.comments, parentId: @state.id}

  _onChange: ->
    @setState getStates()


module.exports = Story
