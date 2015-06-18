React = require 'react'
Mui = require 'material-ui'
ThemeManager = new Mui.Styles.ThemeManager()

AppBar = Mui.AppBar

Store = require '../stores/Store.coffee'
List = require './List.coffee'

customTheme =
  appBar:
    color: '#FF6600'

getStates = ->
  items: Store.getItems()
  comments: Store.getComments()

Main = React.createClass
  getInitialState: ->
    getStates()

  componentWillMount: ->
    ThemeManager.setComponentThemes(customTheme)

  componentDidMount: ->
    Store.addChangeListener @_onChange

  componentWillUnmount: ->
    Store.removeChangeListener @_onChange

  childContextTypes:
    muiTheme: React.PropTypes.object

  getChildContext:  ->
    muiTheme: ThemeManager.getCurrentTheme()

  render: ->
    React.createElement 'main', null,
      React.createElement AppBar, {title: 'My React Hacker News', showMenuIconButton: false}
      React.createElement List, {items: @state.items, comments: @state.comments}

  _onChange: ->
    @setState getStates()

module.exports = Main
