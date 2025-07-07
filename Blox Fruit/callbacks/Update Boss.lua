-- File: callbacks/Boss.lua
local Boss = {}

-- Fungsi untuk mengambil nama boss
local function getBossNames()
    local bossNames = {}

    -- Ambil musuh-musuh dari workspace._WorldOrigin.EnemySpawns
    local enemySpawns = workspace:WaitForChild("_WorldOrigin"):WaitForChild("EnemySpawns")

    -- Loop untuk mencari semua musuh dengan label "Boss"
    for _, enemy in pairs(enemySpawns:GetChildren()) do
        if string.match(enemy.Name, "%[Boss%]") then
            table.insert(bossNames, enemy.Name)  -- Tambahkan nama boss ke list
        end
    end

    return bossNames
end

-- Fungsi untuk Update Boss List
function Boss.UpdateBossList()
    print("Updating Boss List...")
    local updatedBossNames = getBossNames()  -- Ambil nama-nama boss
    return updatedBossNames  -- Kembalikan daftar boss
end

return Boss
