local LrHttp = import'LrHttp'
local LrErrors = import'LrErrors'
local LrPathUtils = import'LrPathUtils'
local LrDate = import'LrDate'

local API_URL = 'http://localhost:3000/api/v1/articles'

local logger = import'LrLogger'('BlogAPI')
logger:enable("logfile")

BlogAPI = {}

function BlogAPI.uploadWork(metadata, photoFilePath)

    local mimeChunks = {}

    for k, v in pairs(metadata) do
      logger:info("k: ", k, " v: ", v)
      mimeChunks[#mimeChunks + 1] = { name = k, value = v}
    end

    -- sane default values in case the user hasn't entered anything
    if metadata["title"] == nil or metadata["title"] == "" then
      mimeChunks[#mimeChunks + 1] = { name = "title", value = "."}
    end

    if metadata["text"] == nil or metadata["text"] == "" then
      mimeChunks[#mimeChunks + 1] = { name = "text", value = "."}
    end

    if metadata["publish_date"] == nil or metadata["publish_date"] == "" then
      mimeChunks[#mimeChunks + 1] = { name = "publish_date", value = LrDate.timeToUserFormat(LrDate.currentTime(), "%Y-%m-%d", false) }
    end

    local fileName = LrPathUtils.leafName(photoFilePath)
    mimeChunks[#mimeChunks + 1] = { name = 'photo', fileName = fileName, filePath = photoFilePath, contentType = 'image/jpeg' }
    mimeChunks[#mimeChunks + 1] = { name = 'passwd', value = 'plop'}

    logger:info('Posting photo ', fileName, 'with ', photoFilePath, 'to', API_URL)
    local result, headers = LrHttp.postMultipart(API_URL, mimeChunks)

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

