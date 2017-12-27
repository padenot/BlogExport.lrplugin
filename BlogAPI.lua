local LrHttp = import'LrHttp'
local LrErrors = import'LrErrors'
local LrPathUtils = import'LrPathUtils'
local LrDate = import'LrDate'

local logger = import'LrLogger'('BlogAPI')
logger:enable("logfile")

BlogAPI = {}

function BlogAPI.uploadWork(metadata, photoFilePath, url, password)

    local mimeChunks = {}

    for k, v in pairs(metadata) do
      logger:info("k: ", k, " v: ", v)
      mimeChunks[#mimeChunks + 1] = { name = k, value = v}
    end

    local fileName = LrPathUtils.leafName(photoFilePath)
    mimeChunks[#mimeChunks + 1] = { name = 'photo', fileName = fileName, filePath = photoFilePath, contentType = 'image/jpeg' }
    mimeChunks[#mimeChunks + 1] = { name = 'passwd', value = password}

    logger:info('Posting photo ', fileName, 'with ', photoFilePath, 'to', url)
    local result, headers = LrHttp.postMultipart(url, mimeChunks)

    if not result then
        if headers and headers.error then
            LrErrors.throwUserError( headers.error.nativeCode)
        end
    end

    if headers.status ~= 200 and headers.status ~= 201 then
        LrErrors.throwUserError(headers.status)
    end

    logger:info('status code:', result)

    return result
end

