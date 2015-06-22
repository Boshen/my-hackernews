React = require 'react'
Immutable = require 'immutable'

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
  margin: '5px 0'
  borderLeft: '5px solid'
  borderLeftColor: colors[index % colors.length]

Comments = React.createClass
  propTypes:
    komments: React.PropTypes.instanceOf(Immutable.Map)
    parentId: React.PropTypes.number.isRequired
    depth: React.PropTypes.number.isRequired

  shouldComponentUpdate: (nextProps) ->
    @props.comments?.get(@props.parentId) isnt nextProps.comments?.get(@props.parentId)

  render: ->
    return null unless @props.comments and @props.comments.has(@props.parentId)

    React.createElement 'div', {className: 'comments'}, @props.comments.get(@props.parentId).map (comment) =>
      return null if comment.get('deleted')
      React.createElement 'div', {key: comment.get('id')},
        React.createElement 'div', {style: commentStyle(@props.depth), className: 'comment', dangerouslySetInnerHTML: {__html: comment.get('text')}}, null
        React.createElement Comments, {comments: @props.comments, parentId: comment.get('id'), depth: @props.depth + 1}

module.exports = Comments
