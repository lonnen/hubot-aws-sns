chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'codinglove', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()

    require('../src/codinglove')(@robot)

  #it 'passes tests', ->
  #  pass
