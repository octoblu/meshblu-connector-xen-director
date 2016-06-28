http = require 'http'

class QueryLatestDesktopOSFailure
  constructor: ({@connector}) ->
    throw new Error 'QueryLatestDesktopOSFailure requires connector' unless @connector?

  do: (message, callback) =>
    query = "Citrix/Monitor/OData/v3/methods/GetMachineFailureTrendsByTypeLatest()?intervalLength=1&numberOfIntervals=0&machineFailureType=0&sessionSupport=2&$format=json"

    @connector.doQuery {query}, (error, data) =>
      return callback error if error?
      metadata =
        code: 200
        status: http.STATUS_CODES[200]

      callback null, {metadata, data}

module.exports = QueryLatestDesktopOSFailure
