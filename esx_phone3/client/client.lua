phone = false
phoneId = 0

local function chatMessage(msg)
	TriggerEvent('chatMessage', '', {0, 0, 0}, msg)
end

phones = {
[0] = "Michael's",
[1] = "Trevor's",
[2] = "Franklin's",
[4] = "Prologue"
}

RegisterNetEvent('camera:phone')
AddEventHandler('camera:phone', function(message)
	local id = tonumber(string.sub(message, 7, 8))

	if id == 0 or id == 1 or id == 2 or id == 4 then
		ChangePhone(id)
	else
		chatMessage("^1/phone [ID]")
		chatMessage("^10 - Michael's phone")
		chatMessage("^11 - Trevor's phone")
		chatMessage("^12 - Franklin's phone")
		chatMessage("^14 - Prologue phone")
	end
end)

function ChangePhone(flag)
	if flag == 0 or flag == 1 or flag == 2 or flag == 4 then
		phoneId = flag
		chatMessage("^2Changed phone to "..phones[flag].." phone")
	end
end

frontCam = false

function CellFrontCamActivate(activate)
	return Citizen.InvokeNative(0x2491A93618B7D838, activate)
end

-- RemoveLoadingPrompt()

TakePhoto = N_0xa67c35c56eb1bd9d
WasPhotoTaken = N_0x0d6ca79eeebd8ca3
SavePhoto = N_0x3dec726c25a11bac
ClearPhoto = N_0xd801cc02177fa3f1

Citizen.CreateThread(function()
DestroyMobilePhone()
	while true do
		Citizen.Wait(0)

		if IsControlJustPressed(0, 118) and phone == true then -- SELFIE MODE
			frontCam = not frontCam
			CellFrontCamActivate(frontCam)
		end

		if IsControlJustPressed(0, 118) then -- OPEN PHONE
			CreateMobilePhone(phoneId)
			CellCamActivate(true, true)
			phone = true
		end

		if IsControlJustPressed(0, 177) and phone == true then -- CLOSE PHONE
			DestroyMobilePhone()
			phone = false
			CellCamActivate(false, false)
			if firstTime == true then
				firstTime = false
				Citizen.Wait(2500)
				displayDoneMission = true
			end
		end

		if IsControlJustPressed(0, 176) and phone == true then -- TAKE.. PIC
			TakePhoto()
			if (WasPhotoTaken() and SavePhoto(-1)) then
				-- SetLoadingPromptTextEntry("CELL_278")
				-- ShowLoadingPrompt(1)
				ClearPhoto()
			end
		end

		if phone == true then
			HideHudComponentThisFrame(7)
			HideHudComponentThisFrame(8)
			HideHudComponentThisFrame(9)
			HideHudComponentThisFrame(6)
			HideHudComponentThisFrame(19)
			HideHudAndRadarThisFrame()
		end

		-- ren = GetMobilePhoneRenderId()
		-- SetTextRenderId(ren)

		-- Everything rendered inside here will appear on your phone.

		-- SetTextRenderId(1) -- NOTE: 1 is default
	end
end)
