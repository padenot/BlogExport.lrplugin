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

    exportPresetFields = {
      { key = 'url', default = "http://localhost:3000/api/v1/articles/"},
      { key = "password", default = "plop"},
    },

    startDialog = ExportDialogs.startDialog,
    sectionsForBottomOfDialog = ExportDialogs.sectionsForBottomOfDialog,
    processRenderedPhotos = BlogUploadTask.processRenderedPhotos,
}
