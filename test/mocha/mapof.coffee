chai = require 'chai'
expect = chai.expect
async = require '../../src/index'

describe "mapOf", ->

  it "should work without error", (cb) ->
    obj =
      one: 1
      two: 2
      three: 3
    async.mapOf obj, (v, k, cb) ->
      cb null, v*2
    , (err, results) ->
      expect(err, 'error').to.not.exist
      expect(results.one, 'one').to.equal 1*2
      expect(results.two, 'two').to.equal 2*2
      expect(results.three, 'three').to.equal 3*2
      cb()

  it "should fail if at least one run fails", (cb) ->
    obj =
      one: 1
      two: 2
      three: 3
    async.mapOf obj, (v, k, cb) ->
      return cb new Error "too large" if v>2
      cb null, v*2
    , (err, results) ->
      expect(err, 'error').to.exist
      cb()