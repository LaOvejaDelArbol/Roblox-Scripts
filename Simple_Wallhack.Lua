local Players = game:GetService("Players") -- Obtener la carpeta de jugadores

function CrearDelineado(parent) -- Crear una funcion para crear un delineado
	local Highlight = Instance.new("Highlight",parent) -- Crear un delineado en el modelo del jugador
	Highlight.FillColor = Color3.fromRGB(48, 148, 157) -- Cambiar el color del relleno (colores RGB)
	Highlight.OutlineColor = Color3.fromRGB(30, 120, 140) -- Cambiar el color del exteririor (colores RGB)
	Highlight.FillTransparency = 0 -- Cambiar la transparencia del relleno (rango 0 - 1)
	Highlight.OutlineTransparency = 0.5 -- Cambiar la transparencia del exterior (rango 0 - 1)
end

for _, Player in Players:GetPlayers() do -- Ciclo por cada jugador actualmente en el server
	if Player == Players.LocalPlayer then continue end -- Si el jugador del ciclo actual somos nosotros pasa al siguiente jugador (para no crear un delineado para nosotros)
	if Player.Character then -- Si exixste el personaje del jugador
		CrearDelineado(Player.Character) -- Creamos un delineado en el personaje del jugador
	end
	Player.CharacterAdded:Connect(function() -- Funcion que se ejecutara cada vez que se cargue un personaje nuevo para ese jugador (cada respawn)
		CrearDelineado(Player.Character) -- Creamos un delineado en el personaje del jugador
	end)
end

Players.PlayerAdded:Connect(function(Player) -- Funcion que se ejecutara cada vez que un jugador nuevo entre al server
	Player.CharacterAdded:Connect(function() -- Funcion que se ejecutara cada vez que se cargue un personaje nuevo para ese jugador (cada respawn)
		CrearDelineado(Player.Character)
	end)
end)