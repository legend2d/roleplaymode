local db = exports.mysql:dbConnect()

function saveNewData()
	local model = getElementModel(source)
	local health = getElementHealth(source)
	local armor = getPedArmor(source)
	local x, y, z = getElementPosition(source)
	local money = getPlayerMoney(source)
	local int = getElementInterior(source)
	local dim = getElementDimension(source)
	dbExec(db, "UPDATE karakterler SET x=? WHERE name=?",x,getPlayerName(source))
	dbExec(db, "UPDATE karakterler SET y=? WHERE name=?",y,getPlayerName(source))
	dbExec(db, "UPDATE karakterler SET z=? WHERE name=?",z,getPlayerName(source))
	dbExec(db, "UPDATE karakterler SET interior=? WHERE name=?",int,getPlayerName(source))
	dbExec(db, "UPDATE karakterler SET dimension=? WHERE name=?",dim,getPlayerName(source))
	dbExec(db, "UPDATE karakterler SET money=? WHERE name=?",money,getPlayerName(source))
	dbExec(db, "UPDATE karakterler SET hp=? WHERE name=?",health,getPlayerName(source))
	dbExec(db, "UPDATE karakterler SET armor=? WHERE name=?",armor,getPlayerName(source))
	dbExec(db, "UPDATE karakterler SET skin=? WHERE name=?",model,getPlayerName(source))
end
addEventHandler("onPlayerQuit", root, saveNewData)