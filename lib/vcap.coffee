# Licensed under the Apache License. See footer for details.

# get a port by name: https://www.npmjs.org/package/ports
ports = require "ports"

# utility belt
utils = require "./utils"

# the name of the mongo service we'll look for
MONGO_SERVICE_NAME = "wiki-mongodb"

#-------------------------------------------------------------------------------
# properties on the vcap object will be the module exports
#-------------------------------------------------------------------------------
vcap = exports

#-------------------------------------------------------------------------------
# set the `app` and `services` properties of the module exports
#-------------------------------------------------------------------------------
vcap.get = ->
    app      = getJSONenv "VCAP_APPLICATION"
    services = getJSONenv "VCAP_SERVICES"

    port     = getPort()
    url      = getURL app, port
    database = getDatabase services

    return {app, services, port, url, database}

#-------------------------------------------------------------------------------
# get data or database option
#-------------------------------------------------------------------------------
getDatabase = (services) ->
    for type, services of services
        for service in services
            if service.name is MONGO_SERVICE_NAME
                utils.log "using mongo database for store"
                result =
                    type: "./mongodb"
                    url:  service.credentials.uri

                return result


    utils.log "using file system for store"
    result =
        type: "./page"

    return result

#-------------------------------------------------------------------------------
# get URL of the server
#-------------------------------------------------------------------------------
getURL = (app, port) ->
    hostName = app?.uris?[0]
    return "http://localhost:#{port}" unless hostName?

    return "https://#{hostName}"

#-------------------------------------------------------------------------------
# get port
#-------------------------------------------------------------------------------
getPort = ->
    portString = process.env.VCAP_APP_PORT ||
                 process.env.PORT ||
                 "#{ports.getPort(utils.PROGRAM)}"

    port = parseInt portString, 10
    if isNaN port
        utils.logError "invalid port specified: #{portString}"

    return port

#-------------------------------------------------------------------------------
# get a JSON environment variable, return as object
#-------------------------------------------------------------------------------
getJSONenv = (name) ->
    jsonEnv = process.env[name]
    return null unless jsonEnv?

    try
        return JSON.parse jsonEnv
    catch e
        utils.logError "expecting environment variable #{name} to be JSON: #{jsonEnv}"

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
