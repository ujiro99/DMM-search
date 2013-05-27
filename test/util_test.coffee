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

  describe 'utf82eucjp のテスト', ->

    it 'null', ->
      fn = ()-> util.utf82eucjp(null)
      expect(fn).to.throw(Error)

    it 'undefined', ->
      fn = ()-> util.utf82eucjp(undefined)
      expect(fn).to.throw(Error)

    it '文字列長 0', ->
      str = util.utf82eucjp('')
      expect(str).to.equal('')

    it 'テスト', ->
      str = util.utf82eucjp('テスト')
      expect(str).to.equal('�ƥ���')

    it 'きゃりーぱみゅぱみゅ', ->
      str = util.utf82eucjp('きゃりーぱみゅぱみゅ')
      expect(str).to.equal('�����꡼�Ѥߤ��Ѥߤ�')

    it '相対性理論', ->
      str = util.utf82eucjp('相対性理論')
      expect(str).to.equal('����������')

    it 'abd', ->
      str = util.utf82eucjp('abd')
      expect(str).to.equal('abd')

    it 'XYZ', ->
      str = util.utf82eucjp('XYZ')
      expect(str).to.equal('XYZ')

    it '0..1', ->
      str = util.utf82eucjp('0..1')
      expect(str).to.equal('0..1')

    it 'tmp', ->
      srt = "%A4%AD%A4%E3%A4%EA%A1%BC%A4%D1%A4%DF%A4%E5%A4%D1%A4%DF%A4%E5"
      str = decodeURIComponent str
      console.log str
      str = util.eucjp2utf8 str
      expect(str).to.equal('きゃりーぱみゅぱみゅ')

