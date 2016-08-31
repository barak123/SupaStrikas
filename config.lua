application =
{
	graphicsCompatibility = 1,

	content =
	{
		width = 320,
		height = 480, 
		scale = "letterBox",
		fps = 30,
		
		--[[
		imageSuffix =
		{
			    ["@2x"] = 2,
		},
		--]]
	},
	license =
    {
        google =
        {
            key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAs15A57sp+3jxt8tjSnYjpLWoArxCSIhqfjYVgsbcGRX4TPvzUw1uklWJDPFtZjdBR0GdfLSJJ5XXVzOfZtdQ7brBPIm+wsDZnkksSAJ74H6/8xcHVJF9SYEWR6nCHKjSb6RC26L7XtuI+2aoyk5j2bEuAb7ChFhzLIFtRboNWXhCDdujXo+Xtp3r9l9RkMwBtXnPdr+DzFR/EsrCES7d9FtuacwOkuFegRtf7dM4IZ1eh+GBcZ/HaKisqsbX3dR12X/FlP1qvqRX5fqXlnTP0rVX0opNmNBJ+7e7kMMwMBBrfN/SzIBDA6/NDGVR/OpbOfB/x556eJpO3eq6OR7bVwIDAQAB",
        },
    },

	--[[
	-- Push notifications
	notification =
	{
		iphone =
		{
			types =
			{
				"badge", "sound", "alert", "newsstand"
			}
		}
	},
	--]]    
}
