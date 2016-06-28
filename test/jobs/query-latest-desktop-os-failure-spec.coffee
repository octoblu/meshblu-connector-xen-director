{job} = require '../../jobs/query-latest-desktop-os-failure'

describe 'QueryLatestDesktopOSFailure', ->
  context 'when given a valid message', ->
    beforeEach (done) ->
      @connector =
        doQuery: sinon.stub().yields null, {}
      message = {}
      @sut = new job {@connector}
      @sut.do message, (@error, {@data}) =>
        done()

    it 'should not error', ->
      expect(@error).not.to.exist

    it 'should call @connector.doQuery', ->
      expect(@connector.doQuery).to.have.been.calledWith query: "Citrix/Monitor/OData/v3/methods/GetMachineFailureTrendsByTypeLatest()?intervalLength=1&numberOfIntervals=0&machineFailureType=0&sessionSupport=1&$format=json"

    it 'should set @data', ->
      expect(@data).to.deep.equal {}
