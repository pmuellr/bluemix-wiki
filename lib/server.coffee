# Licensed under the Apache License. See footer for details.

# "shell" commands implemented as functions
sh = require "shelljs"

# the wiki server
wikiServer = require "wiki/node_modules/wiki-server"

# utility belt
utils = require "./utils"

# get environmental bits
VCAP = require "./vcap"

#-------------------------------------------------------------------------------
# main program here
#-------------------------------------------------------------------------------
exports.main = ->
    vcap = VCAP.get()

    # print the environment variables and vcap info, for debugging
    utils.log "env: #{ JSON.stringify process.env, null, 4}"
    utils.log "vcap: #{JSON.stringify vcap,        null, 4}"

    # copy default data directory
    utils.log "copying default data directory"
    sh.mkdir "-p", "wiki-data"
    sh.rm "-R", "wiki-data/*"
    sh.cp "-R", "node_modules/wiki/node_modules/wiki-server/default-data/*", "wiki-data"

    # options for the wiki server
    options =
        port:     vcap.port
        url:      vcap.url
        database: vcap.database
        data:     "wiki-data"
        client:   "node_modules/wiki/node_modules/wiki-client/client"

    # start the server
    utils.log "starting server with options: #{JSON.stringify options, null, 4}"
    wikiServer options

# all done! server should start listening and responding to requests!

#-------------------------------------------------------------------------------
# run main() if this module was invoked directory from node
#-------------------------------------------------------------------------------
exports.main() if require.main is module

#-------------------------------------------------------------------------------
# Copyright 2014 Patrick Mueller
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#-------------------------------------------------------------------------------
