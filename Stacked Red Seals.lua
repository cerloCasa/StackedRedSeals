--- STEAMODDED HEADER
--- MOD_NAME: Stacked Red Seals
--- MOD_ID: StackedRedSeals
--- MOD_AUTHOR: [Cerlo]
--- MOD_DESCRIPTION: This mod lets you have cards with multiple Red Seals 
--- BADGE_COLOR: F7433A
--- PREFIX: SRS
--- LOADER_VERSION_GEQ: 1.0.0
--- VERSION: 1.3

SMODS.Atlas { -- modicon
    key = 'modicon',
    px = 34,
    py = 34,
    path = 'modicon by @b.b.b.b..png',
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

local config = SMODS.current_mod.config

-- CONFIG TAB
SMODS.current_mod.config_tab = function()
    return {
        -- ROOT NODE
        n = G.UIT.ROOT,
        config = {r = 0.1, minw = 7, minh = 5, align = "tm", padding = 1, colour = G.C.BLACK},
        nodes = {
            {
                -- COLUMN NODE TO ALIGN EVERYTHING INSIDE VERTICALLY
                n = G.UIT.C,
                config = {align = "tm", padding = 0.1, colour = G.C.BLACK},
                nodes = {
                    {
                        -- ROW NODE TO ALIGN THE MaxRedSeals TEXT AND INPUT BOX HORIZONTALLY
                        n = G.UIT.R,
                        config = {align = "cl", minw = 6, minh = 1, colour = G.C.BLACK},
                        nodes = {
                            {
                                -- TEXT DISPLAY
                                n = G.UIT.T,
                                config = {text = "Maximum retriggers per card: ", scale = .5, minw = 4, minh = 1, colour = G.C.WHITE}
                            },
                            create_text_input({
                                id = 'Input:MaxRedSeals',
                                w = 2,
                                max_length = 3,
                                prompt_text = "-1",
                                ref_table = config,
                                ref_value = 'MaxRedSeals'
                            })
                        }
                    },

                    {
                        -- ROW NODE FOR THE DESCRIPTION OF THE MaxRedSeal SETTING
                        n = G.UIT.R,
                        config = {align = "cl", minw = 6, minh = 1, colour = G.C.BLACK},
                        nodes = {
                            {
                                -- TEXT DISPLAY
                                n = G.UIT.T,
                                config = {text = "This option modifies the maximum amount of Red Seals a card can have. Set it to 0 for limitless Red Seals.", maxw = 4, maxh = 1, scale = .3, colour = G.C.WHITE}
                            },
                        }
                    },

                    {
                        -- ROW NODE TO ALIGN THE RedSealsPerCard TEXT AND INPUT BOX HORIZONTALLY
                        n = G.UIT.R,
                        config = {align = "cl", minw = 6, minh = 1, colour = G.C.BLACK},
                        nodes = {
                            {
                                -- TEXT DISPLAY
                                n = G.UIT.T,
                                config = {text = "Red Seals per Deja Vu: ", scale = .5, minw = 4, minh = 1, colour = G.C.WHITE}
                            },
                            create_text_input({
                                id = 'Input:RedSealsPerCard',
                                w = 2,
                                max_length = 3,
                                prompt_text = "1",
                                ref_table = config,
                                ref_value = 'RedSealsPerCard'
                            })
                        }
                    },

                    {
                        -- ROW NODE FOR THE DESCRIPTION OF THE RedSealsPerCard SETTING
                        n = G.UIT.R,
                        config = {align = "cl", minw = 6, minh = 1, colour = G.C.BLACK},
                        nodes = {
                            {
                                -- TEXT DISPLAY
                                n = G.UIT.T,
                                config = {text = "This option modifies the amount of retriggers that each Deja Vu card gives to the selected playing card.", maxw = 4, maxh = 1, scale = .3, colour = G.C.WHITE}
                            },
                        }
                    },
                }
            }
        }
    }
end

function SRS_setRedSeal(card,seal)
    -- Use a lovely.toml patch to hook this function inside Card:set_seal
    local RedSealsPerCard = tonumber((string.gsub(config.RedSealsPerCard,"%D","0")))
    local MaxRedSeals = tonumber((string.gsub(config.MaxRedSeals,"%D","0")))

    if card.area ~= G.hand then
        return
    end
    if seal == 'Red' then
        if card.ability.SRSreps then
            -- If the card has already Red Seal
            card.ability.SRSreps = card.ability.SRSreps + RedSealsPerCard
        else
            -- If the card doesn't have already Red Seal
            card.ability.SRSreps = RedSealsPerCard
        end
        if card.ability.SRSreps > MaxRedSeals and MaxRedSeals > 0 then
            -- If the repetitions exceed the limit, set them to the limit
            card.ability.SRSreps = MaxRedSeals
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