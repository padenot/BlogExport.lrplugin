return {
    LrSdkVersion = 3.0,
    LrSdkMinimumVersion = 3.0,

    LrToolkitIdentifier = 'cx.paul.lrupload',
    LrPluginName = "Blog Uploader",

    LrMetadataProvider = 'blogmetadataprovider.lua',
    LrMetadataTagsetFactory = 'tagset.lua',

    LrExportServiceProvider = {
        title = "Blog Upload",
        file = "ExportServiceProvider.lua",
    },

    VERSION = { major = 0, minor = 0, revision = 0, build = 1, },
}
