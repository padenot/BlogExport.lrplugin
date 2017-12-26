local LrView = import 'LrView'
local bind = LrView.bind


ExportDialogs = {}

local function updateProperties(propertyTable)
end

function ExportDialogs.startDialog(propertyTable)
  propertyTable:addObserver('url', updateProperties)
end

function ExportDialogs.workDetailsDialog(ui, propertyTable)
    return {
    }
end

function ExportDialogs.sectionsForBottomOfDialog( _, propertyTable )

  local f = LrView.osFactory()
  local bind = LrView.bind
  local share = LrView.share

  local result = {

    {
      title = "Blog export settings",
      synopsis = bind { key = 'fullPath', object = propertyTable },
      f:row {
        f:static_text {
          title = "API endpoint:",
        },

        f:edit_field {
          value = bind 'url',
          enabled = true,
          immediate = true,
          fill_horizontal = 1
        },
      },
      f:row {
        f:static_text {
          title = "Password:",
        },

        f:password_field {
          value = bind 'password',
          fill_horizontal = 1,
        },
      },
    },
  }
  
  return result
  
end
