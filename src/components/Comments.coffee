React = require 'react'
PureRenderMixin = require('react/addons').addons.PureRenderMixin
Immutable = require 'immutable'

Paper = require('material-ui').Paper

Comments = React.createClass
  mixins: [PureRenderMixin]

  propTypes:
    comments: React.PropTypes.instanceOf(Immutable.Map)
    parentId: React.PropTypes.number.isRequired

  render: ->
    return null unless @props.comments and @props.comments.has(@props.parentId)

    React.createElement Paper, {className: 'comments'}, @props.comments.get(@props.parentId).map (comment, i) =>

      React.createElement 'div', {key: comment.get('id')},
        React.createElement 'div', {className: 'comment' , dangerouslySetInnerHTML: {__html: comment.get('text')}}, null
        React.createElement Comments, {comments: @props.comments, parentId: comment.get('id')}

module.exports = Comments
