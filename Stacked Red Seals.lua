--- STEAMODDED HEADER
--- MOD_NAME: Stacked Red Seals
--- MOD_ID: StackedRedSeals
--- MOD_AUTHOR: [CerloCasa]
--- MOD_DESCRIPTION: This mod lets you have cards with multiple Red Seals 
--- BADGE_COLOR: F7433A
--- PREFIX: SRS
--- LOADER_VERSION_GEQ: 1.0.0
--- VERSION: snapshot24w29a

function SMODS.current_mod.process_loc_text()
    G.localization.descriptions.Other['SRSredSealDefinition'] = {
        name = 'Red Seal',
        text = {
            "Retrigger this",
            "card {C:attention}1{} more time"
          }
    }
    G.localization.descriptions.Other['SRSredSeal1'] = {
        name = 'Red Seal',
        text = {
            "Retrigger this",
            "card {C:attention}1{} time"
          }
    }
    G.localization.descriptions.Other['SRSredSeal2'] = {
        name = 'Red Seal',
        text = {
            "Retrigger this",
            "card {C:attention}#1#{} times"
          }
    }
    sendTraceMessage("Lock text done","SRSprocessLocText")
end

function SRS_setRedSeal(card,seal)
    -- Use a lovely.toml patch to hook this function inside Card:set_seal
    if seal.ability.name == 'Red Seal' then
        if card.SRSreps then
            card.SRSreps = card.SRSreps + 1
        else
            card.SRSreps = 1
        end
    else
        card.SRSreps = nil
    end
end