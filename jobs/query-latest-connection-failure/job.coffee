http = require 'http'

class QueryLatestConnectionFailure
  constructor: ({@connector}) ->
    throw new Error 'QueryLatestConnectionFailure requires connector' unless @connector?

  do: (message, callback) =>
    query = "Citrix/Monitor/OData/v3/methods/GetConnectionFailureTrendsByTypeLatest()?intervalLength=1&numberOfIntervals=60&connectionFailureType=0&$format=json"

    @connector.doQuery {query}, (error, data) =>
      return callback error if error?
      metadata =
        code: 200
        status: http.STATUS_CODES[200]

      callback null, {metadata, data}

module.exports = QueryLatestConnectionFailure
