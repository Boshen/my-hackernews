React = require 'react'
Router = require 'react-router'
Route = Router.Route
RouteHandler = Router.RouteHandler
DefaultRoute = Router.DefaultRoute

Main = require './components/Main.coffee'
Story = require './components/Story.coffee'

App = React.createClass
  render: ->
    React.createElement 'main', null,
      React.createElement RouteHandler, null

routes = React.createElement Route, {path: '/', handler: App},
    React.createElement DefaultRoute, {handler: Main}
    React.createElement Route, {name: 'story', path: 'story/:id', handler: Story}

Router.run routes, Router.HashLocation, (Root) ->
  React.render(React.createElement(Root, null), document.body)
