# Licensed under the Apache License. See footer for details.

# read the `package.json` file for this package, so we can reference
# the name property later
pkg = require "../package.json"

#-------------------------------------------------------------------------------
# properties on thethe utils object will be the module exports
#-------------------------------------------------------------------------------
utils = exports

#-------------------------------------------------------------------------------
# get the program name and version
#-------------------------------------------------------------------------------
utils.PROGRAM = pkg.name
utils.VERSION = pkg.version

#-------------------------------------------------------------------------------
# log the environment variables
#-------------------------------------------------------------------------------
utils.dump_env = ->
    utils.log "environment variables:"
    for key, val of process.env
        utils.log "   #{key}: #{val}"

#-------------------------------------------------------------------------------
# log a message with a common prefix of the package name
#-------------------------------------------------------------------------------
utils.log = (message) ->
    console.log pkg.name + ": " + message

#-------------------------------------------------------------------------------
# log a message and then quit
#-------------------------------------------------------------------------------
utils.logError = (message) ->
    utils.log message
    process.exit 1


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
