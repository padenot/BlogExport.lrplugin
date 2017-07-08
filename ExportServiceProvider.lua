require 'ExportDialogs'
require 'BlogUploadTask'
local logger = import'LrLogger'('BlogAPI')
logger:enable("logfile")

return {
    hideSections = { 'exportLocation', 'watermarking', 'fileNaming' },
    allowFileFormats = { 'JPEG' },
    allowColorSpaces = {'sRGB'},
    hidePrintResolution = true,
    canExportVideo = false,

    startDialog = ExportDialogs.startDialog,
    processRenderedPhotos = BlogUploadTask.processRenderedPhotos,
}
