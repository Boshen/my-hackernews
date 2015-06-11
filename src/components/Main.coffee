React = require 'react'
Firebase = require 'firebase'
ReactFireMixin = require 'reactfire'
_ = require 'lodash'


api = 'https://hacker-news.firebaseio.com/v0'

Main = React.createClass
  mixins: [ReactFireMixin]

  getInitialState: ->
    items: {}

  componentWillMount: ->
    firebaseRef = new Firebase(api + '/topstories')
    this.bindAsObject(firebaseRef, "items")

  componentWillUnmount: ->
    this.unbind("items")

  render: ->

    items = _.mapValues @state.items, (id)->
      React.createElement('li', null, id)

    React.createElement('ul', null, items)

module.exports = Main
