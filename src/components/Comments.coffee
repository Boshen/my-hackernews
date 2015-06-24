React = require 'react'
Immutable = require 'immutable'

div = React.DOM.div

colors = [
  '#FF5722'
  '#303F9F'
  '#D32F2F'
  '#009688'
  '#1976D2'
  '#388E3C'
]

commentStyle = (index) ->
  padding: '10px'
  margin: '20px'
  borderLeft: '5px solid'
  borderLeftColor: colors[index % colors.length]

Comments = React.createClass
  propTypes:
    komments: React.PropTypes.instanceOf(Immutable.Map)
    parentId: React.PropTypes.number.isRequired
    depth: React.PropTypes.number

  getInitialState: ->
    depth: @props.depth or 0

  shouldComponentUpdate: (nextProps) ->
    @props.comments?.get(@props.parentId) isnt nextProps.comments?.get(@props.parentId)

  render: ->
    return null unless @props.comments and @props.comments.has(@props.parentId)

    div className: 'comments', @props.comments.get(@props.parentId).map (comment) =>
      return null if comment.get('deleted')
      div key: comment.get('id'),
        div {style: commentStyle(@state.depth), className: 'comment', dangerouslySetInnerHTML: {__html: comment.get('text')}}
        React.createElement Comments, {comments: @props.comments, parentId: comment.get('id'), depth: @state.depth + 1}

module.exports = Comments
