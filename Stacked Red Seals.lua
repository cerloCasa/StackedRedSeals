--- STEAMODDED HEADER
--- MOD_NAME: Stacked Red Seals
--- MOD_ID: StackedRedSeals
--- MOD_AUTHOR: [Cerlo]
--- MOD_DESCRIPTION: This mod lets you have cards with multiple Red Seals 
--- BADGE_COLOR: F7433A
--- PREFIX: SRS
--- LOADER_VERSION_GEQ: 1.0.0
--- VERSION: 1.2

SMODS.Atlas { -- modicon
    key = 'modicon',
    px = 34,
    py = 34,
    path = 'modicon.png',
}   

load(NFS.read(SMODS.current_mod.path .. 'config.lua'))()

function SMODS.current_mod.process_loc_text()
    G.localization.descriptions.Other['SRSredSealDefinition'] = {
        name = 'Red Seal',
        text = {
            "Retrigger this",
            "card {C:attention}1{} more time"
          }
    }
    G.localization.descriptions.Other['SRSredSeal'] = {
        name = 'Stacked Red Seals',
        text = {
            "Retrigger this",
            "card {C:attention}#1#{} times"
          }
    }
    sendTraceMessage("Lock text done","SRSprocessLocText")
end

function SRS_setRedSeal(card,seal)
    G.consumeables.config.card_limit = 150
    -- Use a lovely.toml patch to hook this function inside Card:set_seal
    if card.area ~= G.hand then
        return
    end
    if seal == 'Red' then
        if card.ability.SRSreps then
            -- If the card has already Red Seal
            card.ability.SRSreps = card.ability.SRSreps + SRS_RedSealsForCard
        else
            -- If the card doesn't have already Red Seal
            card.ability.SRSreps = SRS_RedSealsForCard
        end
        if card.ability.SRSreps > SRS_MaxRedSeals and SRS_MaxRedSeals >= 0 then
            -- If the repetitions exceed the limit, set them to the limit
            card.ability.SRSreps = SRS_MaxRedSeals
        end
        if card.ability.SRSreps == 0 then
            -- If the repetitions are 0, remove the Red Seal
            card.ability.SRSreps = nil
            card.seal = nil
        end
    else
        card.ability.SRSreps = nil
    end
end