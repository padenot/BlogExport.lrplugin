local LrHttp = import'LrHttp'
local LrFileUtils = import'LrFileUtils'

require'BlogAPI'

local logger = import'LrLogger'('BlogAPI')

BlogUploadTask = {}

function BlogUploadTask.processRenderedPhotos(functionContext, exportContext)

    local exportSession = exportContext.exportSession
    local exportParams = exportContext.propertyTable
    local url = exportParams.url
    local password = exportParams.password

    logger:info("url: ", url, " pass: ", password)

    local progressScope = exportContext:configureProgress{
        title = "Uploading work to the blog"
    }

    for index, rendition in exportContext:renditions{ stopIfCanceled = true } do
        local photo = rendition.photo

        if not rendition.wasSkipped then
            local success, pathOrMessage = rendition:waitForRender()

            if success then
                workUrl = BlogAPI.uploadWork({
                    title = photo:getPropertyForPlugin(_PLUGIN, "title"),
                    text = photo:getPropertyForPlugin(_PLUGIN, "text"),
                    hashtags = photo:getPropertyForPlugin(_PLUGIN, "hashtags"),
                    publish_date = photo:getPropertyForPlugin(_PLUGIN, "publishdate"),
                  }, pathOrMessage, url, password)

                LrFileUtils.delete( pathOrMessage )
            end
        end
    end

    progressScope:done()
end
