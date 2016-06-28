Connector = require '../'

describe 'Connector', ->
  beforeEach (done) ->
    @sut = new Connector
    {@request} = @sut
    @request.get = sinon.stub().yields null, {}, 'foo'
    options =
      protocol: 'https'
      domain: 'foo.bar'
      customerId: 'sample'
      username: 'name'
      password: 'secret'
    @sut.start {options}, done

  afterEach (done) ->
    @sut.close done

  describe '->isOnline', ->
    it 'should yield running true', (done) ->
      @sut.isOnline (error, response) =>
        return done error if error?
        expect(response.running).to.be.true
        done()

  describe '->onConfig', ->
    describe 'when called with a config', ->
      it 'should not throw an error', ->
        expect(=> @sut.onConfig { type: 'hello' }).to.not.throw(Error)

  describe '->doQuery', ->
    beforeEach (done) ->
      @sut.doQuery {}, done

    it 'should call request.get', ->
      options =
        auth:
          password: 'secret'
          username: 'foo.bar/name'
        json: true
      expect(@request.get).to.have.been.calledWith 'https://sample.foo.bar', options
