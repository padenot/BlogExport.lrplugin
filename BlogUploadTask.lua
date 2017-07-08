local LrHttp = import'LrHttp'
local LrFileUtils = import'LrFileUtils'
local LrFileUtils = import'LrFileUtils'

require'BlogAPI'

BlogUploadTask = {}

function BlogUploadTask.processRenderedPhotos(functionContext, exportContext)

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
                    publish_date = photo:getPropertyForPlugin(_PLUGIN, "publishdate")
                  }, pathOrMessage)

                LrFileUtils.delete( pathOrMessage )

                progressScope:done()

                LrHttp.openUrlInBrowser(workUrl)
            end
        end
    end
end
