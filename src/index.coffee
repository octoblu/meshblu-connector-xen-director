{EventEmitter}  = require 'events'
debug           = require('debug')('meshblu-connector-xen-director:index')
URL             = require 'url'
request         = require 'request'

class Connector extends EventEmitter
  constructor: ->
    # hook for testing
    @request = request

  isOnline: (callback) =>
    callback null, running: true

  close: (callback) =>
    debug 'on close'
    callback()

  onConfig: (device={}) =>
    { @options } = device
    debug 'on config', @options

  doQuery: ({query}, callback) =>
    url = URL.format {
      protocol: @options.protocol
      hostname: "#{@options.customerId}.#{@options.domain}"
      search: query
    }

    options =
      json: true
      auth:
        username: "#{@options.domain}/#{@options.username}"
        password: @options.password

    @request.get url, options, (error, response, body) =>
      return callback error if error?
      if response.statusCode > 399
        error = new Error "Invalid Response Code"
        error.code = response.statusCode
        return callback error

      callback null, body

  start: (device, callback) =>
    debug 'started'
    @onConfig device
    callback()

module.exports = Connector
