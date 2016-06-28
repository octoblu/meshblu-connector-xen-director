http = require 'http'

class QueryActiveRunningSessionsCount
  constructor: ({@connector}) ->
    throw new Error 'QueryActiveRunningSessionsCount requires connector' unless @connector?

  do: (message, callback) =>
    query = "Citrix/Monitor/OData/v3/methods/GetConcurrentSessionsTrendLatest()?intervalLength=1&numberOfIntervals=60&$format=json"

    @connector.doQuery {query}, (error, data) =>
      return callback error if error?
      metadata =
        code: 200
        status: http.STATUS_CODES[200]

      callback null, {metadata, data}

module.exports = QueryActiveRunningSessionsCount
