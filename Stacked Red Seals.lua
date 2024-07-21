--- STEAMODDED HEADER
--- MOD_NAME: Stacked Red Seals
--- MOD_ID: StackedRedSeals
--- MOD_AUTHOR: [Cerlo]
--- MOD_DESCRIPTION: This mod lets you have cards with multiple Red Seals 
--- BADGE_COLOR: F7433A
--- PREFIX: SRS
--- LOADER_VERSION_GEQ: 1.0.0
--- VERSION: 1.1

SMODS.Atlas { -- modicon
    key = 'modicon',
    px = 34,
    py = 34,
    path = 'modicon.png',
}   

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
    -- Use a lovely.toml patch to hook this function inside Card:set_seal
    if card.area ~= G.hand then
        return
    end
    if seal == 'Red' then
        if card.ability.SRSreps then
            card.ability.SRSreps = card.ability.SRSreps + 1
        else
            card.ability.SRSreps = 1
        end
    else
        card.ability.SRSreps = nil
    end
end