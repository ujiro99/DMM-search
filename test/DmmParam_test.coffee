fs     = require 'fs'
chai   = require 'chai'
expect = chai.expect
DmmParam = require '../app/models/DmmParam'

describe 'DmmParam.coffee のテスト', ->

  describe 'buildQuery のテスト', ->

    it 'site: DMM.co.jp', ->
      param =
        site: 'DMM.co.jp'
      uri = DmmParam.buildQuery param
      expect(uri).to.contain('DMM.co.jp')

