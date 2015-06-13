React = require 'react'
Main = require './components/Main.coffee'
HackerNewsApi = require './utils/HackerNewsApi.coffee'

HackerNewsApi.init()

React.render React.createElement(Main, null), document.getElementById('main')
