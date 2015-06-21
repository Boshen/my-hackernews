React = require 'react'
Router = require 'react-router'
Route = Router.Route
RouteHandler = Router.RouteHandler
DefaultRoute = Router.DefaultRoute

StoriesPage = require './pages/StoriesPage.coffee'
CommentsPage = require './pages/CommentsPage.coffee'

App = React.createClass
  render: ->
    React.createElement 'main', null,
      React.createElement RouteHandler, null

routes = React.createElement Route, {path: '/', handler: App},
    React.createElement DefaultRoute, {handler: StoriesPage}
    React.createElement Route, {name: 'story', path: 'story/:id', handler: CommentsPage}

Router.run routes, Router.HashLocation, (Root) ->
  React.render(React.createElement(Root, null), document.body)
