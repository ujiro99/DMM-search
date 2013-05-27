fs     = require 'fs'
chai   = require 'chai'
expect = chai.expect
util   = require '../app/util'

describe 'util.coffee のテスト', ->

  # テストが始まる前の処理
  before (done) ->
    done()

  # テストが終わった後の処理
  after (done) ->
    done()

  # 各テストごとの始まる前の処理
  beforeEach (done) ->
    done()

  # 各テストごとの終わった後の処理
  afterEach (done) ->
    done()

  describe 'getTimestamp のテスト', ->

  describe 'xml2json のテスト', ->

    it 'rental ppr_cd やくしまるえつこ', ->
      xml = fs.readFileSync('./test/data/response.xml')
      json = util.xml2json xml
      expect(json).to.have.keys('response')
      expect(json.response.result.items.item[0].title).to.equal('RADIO ONSEN EUTOPIA/やくしまるえつこ')
      expect(json.response.result.items.item[19].title).to.equal('Keiichi Suzuki:Music for Films and Games/Original Soundtracks/鈴木慶一')

