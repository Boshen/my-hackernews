React = require 'react'
Main = require './components/Main.coffee'
Actions = require './actions/Actions.coffee'

Actions.init()

React.render React.createElement(Main, null), document.getElementsByTagName('body')[0]
