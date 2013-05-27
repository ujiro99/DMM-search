process.env.NODE_PATH = '/Users/tu/.nvm/v0.8.4/lib/node_modules'
spawn = require('child_process').spawn


task 'test', 'run tests', ->
  spawn 'mocha' ,[
    '--reporter', 'spec'
    '--compilers', 'coffee:coffee-script', 'test/'
    ]
  ,{ stdio: 'inherit'}

