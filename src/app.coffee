React = require 'react'
Router = require 'react-router'
Route = React.createFactory Router.Route
RouteHandler = React.createFactory Router.RouteHandler
DefaultRoute = React.createFactory Router.DefaultRoute

StoriesPage = require './pages/StoriesPage.coffee'
CommentsPage = require './pages/CommentsPage.coffee'

main = React.DOM.main

App = React.createClass
  render: ->
    main null,
      RouteHandler null

routes = Route {path: '/', handler: App},
    DefaultRoute {handler: StoriesPage}
    Route {name: 'story', path: 'story/:id', handler: CommentsPage}

Router.run routes, Router.HashLocation, (Root) ->
  React.render(React.createElement(Root, null), document.body)
