print("Obscure has been loaded...")

local M = {}
local http = require("socket.http")
local ltn12 = require("ltn12")

function M.say_hello()
    print("Hello, World!")
end

function M.make_api_call(url)
    local response_body = {}
    local res, code, response_headers = http.request{
        url = url,
        sink = ltn12.sink.table(response_body)
    }

    if res == 1 then
        return table.concat(response_body), code, response_headers
    else
        return nil, code
    end
end

function M.print_api_response()
    local url = "https://api.dictionaryapi.dev/api/v2/entries/en/obscure"
    local response, status_code, headers = M.make_api_call(url)

    if response then
        print("Response: " .. response)
        print("Status code: " .. status_code)
    else
        print("Failed to make request. Status code: " .. status_code)
    end
end

return M
