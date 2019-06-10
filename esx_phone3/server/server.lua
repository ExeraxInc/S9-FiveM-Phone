AddEventHandler('chatMessage', function(source, name, message)
	if message:sub(1,6) == '/camera' then
		TriggerClientEvent('camera:phone', source, message)
		CancelEvent()
	end
end)
