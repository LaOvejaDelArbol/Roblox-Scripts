local Players = game:GetService("Players") -- Obtener la carpeta de jugadores
local Teams = game:GetService("Teams") -- Obtenemos la carpeta de equipos

local Team_Name = "Team2" -- Nombre del equipo (editar)

function CrearDelineado(parent) -- Crear una funcion para crear un delineado
	if Players:GetPlayerFromCharacter(parent).Team ~= Teams:FindFirstChild(Team_Name) or parent:FindFirstChild("HighlightExp") then return end -- Si el jugador no pertenece al Team o ya tiene un delineado
	local Highlight = Instance.new("Highlight",parent) -- Crear un delineado y ponerlo en el modelo del jugador que le pasemos
	Highlight.Name = "HighlightExp" -- Cambiamos el nombre para luego poder encontrarlo
	-- // CUSTOMIZACION DE HIGHLIGHT // (opcional)
	Highlight.FillColor = Color3.fromRGB(255, 0, 4) -- Cambiar el color del relleno
	Highlight.OutlineColor = Color3.fromRGB(140, 0, 2) -- Cambiar el color del exteririor
	Highlight.FillTransparency = 0 -- Cambiar la transparencia del relleno (rango 0 - 1)
	Highlight.OutlineTransparency = 0 -- Cambiar la transparencia del exterior (rango 0 - 1)
end


for _, Player in Teams:WaitForChild(Team_Name):GetPlayers() do -- Ciclo por cada jugador actualmente en el equipo 2 (cambiar el nombre del equipo)
	if Player == Players.LocalPlayer then continue end -- Si el jugador del ciclo actual somos nosotros pasa al siguiente jugador (para no crear un delineado para nosotros)
	if Player.Character then -- Si exixste el personaje del jugador
		CrearDelineado(Player.Character) -- Creamos un delineado en el personaje del jugador
	end
	Player.CharacterAdded:Connect(function() -- Funcion que se ejecutara cada vez que se cargue un personaje nuevo para ese jugador (cada respawn)
		CrearDelineado(Player.Character) -- Creamos un delineado en el personaje del jugador
	end)
end

Teams:FindFirstChild(Team_Name).PlayerAdded:Connect(function(Player) -- Funcion que se ejecuta cada vez que se añade un jugador al equipo
	if Player == Players.LocalPlayer then return end -- Si el jugador añadido somos nosotros para
	if Player.Character then -- Si exixste el personaje del jugador y no existe delineado
		CrearDelineado(Player.Character) -- Creamos un delineado en el personaje del jugador
	end
	Player.CharacterAdded:Connect(function() -- Funcion que se ejecutara cada vez que se cargue un personaje nuevo para ese jugador (cada respawn)
		CrearDelineado(Player.Character) -- Creamos un delineado en el personaje del jugador
	end)
end)

Teams:FindFirstChild(Team_Name).PlayerRemoved:Connect(function(Player) -- Funcion que se ejecuta cada vez que se elimina un jugador del equipo
	if Player.Character and Player.Character:FindFirstChild("HighlightExp") then -- Comprobar si existe un delineado
		Player.Character:FindFirstChild("HighlightExp"):Destroy() -- En ese caso eliminar el delineado
	end
end)