'use strict'

module.exports = (grunt) ->

  # Load plugins automatically
  require("load-grunt-tasks") grunt

  # set variables
  config =
    dist: 'public/elements'

  # configure
  grunt.initConfig

    config: config


    ###
     esteWatch
    ###
    esteWatch:
      options:
        dirs: [
            'public/elements'
          ]
        livereload:
          enabled: true
          port: 35729
          extensions: ['coffee', 'stylus', 'jade', 'html']
      # extension settings
      coffee: (path) ->
        grunt.config 'coffee.options.bare', true
        grunt.config 'coffee.compile.files', [
          nonull: true
          expand: true
          cwd: 'public/elements'
          src: path.slice(path.indexOf('/'))
          dest: '<%= config.dist %>/'
          ext: '.js'
        ]
        'coffee:compile'
      styl: (path) ->
        grunt.config 'stylus.options.compress', false
        grunt.config 'stylus.compile.files', [
          nonull: true
          expand: true
          cwd: 'public/elements'
          src: path.slice(path.indexOf('/'))
          dest: '<%= config.dist %>/'
          ext: '.css'
        ]
        'stylus:compile'
      jade: (path) ->
        grunt.config 'jade.options.data', { production: false }
        grunt.config 'jade.options.pretty', true
        grunt.config 'jade.compile.files', [
          nonull: true
          expand: true
          cwd: 'public/elements'
          src: path.slice(path.indexOf('/'))
          dest: '<%= config.dist %>/'
          ext: '.html'
        ]
        'jade:compile'

    ###
     vulcanize
    ###
    vulcanize:
      default:
        options: {
          inline: true
          strip: true
        }
        files: {
          'public/elements/packaged.html': 'public/elements/search-result/search-result.html'
        }

    ###
     coffee script
    ###
    coffee:
      develop:
        files: [
          expand: true
          cwd: 'public/elements'
          src: ['**/*.coffee']
          dest: '<%= config.dist %>/'
          ext: '.js'
        ]

    ###
     stylus
    ###
    stylus:
      develop:
        files: [
          expand: true
          cwd: 'public/elements'
          src: ['**/*.styl']
          dest: '<%= config.dist %>/'
          ext: '.css'
        ]

    ###
     jade
    ###
    jade:
      develop:
        options:
          data: (dest, src) -> return { production: false }
        files: [
          expand: true
          cwd: 'public/elements'
          src: ['**/*.jade']
          dest: '<%= config.dist %>/'
          ext: '.html'
        ]

  grunt.registerTask('watch', ['esteWatch'])
  grunt.registerTask('vul', ['coffee', 'stylus', 'jade', 'vulcanize'])
  grunt.registerTask('heroku', ['jshint'])

