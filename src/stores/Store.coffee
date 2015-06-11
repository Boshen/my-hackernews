Dispatcher = require '../dispatcher/Dispatcher'
EventEmitter = require('events').EventEmitter
_ = require 'lodash'

_items = []

Store = _.assign {}, EventEmitter.prototype, {}

module.exports = Store
