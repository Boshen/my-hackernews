React = require 'react'
Immutable = require 'immutable'

Comments = React.createClass
  propTypes:
    komments: React.PropTypes.instanceOf(Immutable.Map)
    parentId: React.PropTypes.number.isRequired

  shouldComponentUpdate: (nextProps) ->
    @props.comments?.get(@props.parentId) isnt nextProps.comments?.get(@props.parentId)

  render: ->
    return null unless @props.comments and @props.comments.has(@props.parentId)

    React.createElement 'div', {className: 'comments'}, @props.comments.get(@props.parentId).map (comment) =>
      return null if comment.get('deleted')
      React.createElement 'div', {key: comment.get('id')},
        React.createElement 'div', {className: 'comment', dangerouslySetInnerHTML: {__html: comment.get('text')}}, null
        React.createElement Comments, {comments: @props.comments, parentId: comment.get('id')}

module.exports = Comments
