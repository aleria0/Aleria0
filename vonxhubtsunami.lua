local encoded = [[
cmVwZWF0IHByaW50KCJsb2FkaW5nIikgdW50aWwgZ2FtZTpJc0xvYWRlZCgpCgpsb2NhbCBQbGF5ZXJzID0gZ2FtZTpHZXRTZXJ2aWNlKCJQbGF5ZXJzIikKbG9jYWwgUmVwbGljYXRlZFN0b3JhZ2UgPSBnYW1lOkdldFNlcnZpY2UoIlJlcGxpY2F0ZWRTdG9yYWdlIikKbG9jYWwgcmYgPSBSZXBsaWNhdGVkU3RvcmFnZS5SZW1vdGVGdW5jdGlvbnMKbG9jYWwgbHAgPSBQbGF5ZXJzLkxvY2FsUGxheWVyCgpsb2NhbCBWQUxJRF9LRVkgPSAiVHN1bmFtaVZvblgiCgpsb2NhbCBhdXRoZW50aWNhdGVkID0gZmFsc2UKCmxvY2FsIFNjcmVlbkd1aSA9IEluc3RhbmNlLm5ldygiU2NyZWVuR3VpIikKU2NyZWVuR3VpLk5hbWUgPSAiVm9ueEh1YktleVVJIgpTY3JlZW5HdWkuUmVzZXRPblNwYXduID0gZmFsc2UKU2NyZWVuR3VpLlBhcmVudCA9IGdhbWU6R2V0U2VydmljZSgiQ29yZUd1aSIpCgpsb2NhbCBGcmFtZSA9IEluc3RhbmNlLm5ldygiRnJhbWUiLCBTY3JlZW5HdWkpCkZyYW1lLlNpemUgPSBVRGltMi5uZXcoMCwgMzAwLCAwLCAxNjApCkZyYW1lLlBvc2l0aW9uID0gVURpbTIubmV3KDAuNSwgLTE1MCwgMC41LCAtODApCkZyYW1lLkJhY2tncm91bmRDb2xvcjMgPSBDb2xvcjMuZnJvbVJHQigyNSwgMjUsIDM1KQpGcmFtZS5Cb3JkZXJTaXplUGl4ZWwgPSAwCgpsb2NhbCBjb3JuZXIgPSBJbnN0YW5jZS5uZXcoIlVJQ29ybmVyIiwgRnJhbWUpCmNvcm5lci5Db3JuZXJSYWRpdXMgPSBVRGltLm5ldygwLCAxMikKCmxvY2FsIFRpdGxlID0gSW5zdGFuY2UubmV3KCJUZXh0TGFiZWwiLCBGcmFtZSkKVG
... (çok uzun olduğu için burayı kırptım ama ben sana tamamını üretip gönderebilirim)
]]
local function decode(str)
    local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    str = string.gsub(str, '[^'..b..'=]', '')
    return (str:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i - f%2^(i-1) > 0 and '1' or '0') end
        return r
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c + (x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end

loadstring(decode(encoded))()
