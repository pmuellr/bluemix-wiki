# Licensed under the Apache License. See footer for details.

# use this file with jbuild: https://www.npmjs.org/package/jbuild

#-------------------------------------------------------------------------------
tasks = defineTasks exports,
    watch :   "watch for source file changes, restart server"
    serve:    "run the test server stand-alone"

WatchSpec = "*.js lib/**/*"

#-------------------------------------------------------------------------------
mkdir "-p", "tmp"

#-------------------------------------------------------------------------------
tasks.watch = ->
    tasks.serve()

    watch
        files: WatchSpec.split " "
        run:   tasks.serve

    watchFiles "jbuild.coffee" :->
        log "jbuild file changed; exiting"
        process.exit 0

#-------------------------------------------------------------------------------
tasks.serve = ->
    [cmd, args...] = "node server".split " "
    server.start "tmp/server.pid", cmd, args

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
