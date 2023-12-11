import Foundation

extension System {
    static func with(id: Int) -> System {
        all.first(where: { $0.id == id }) ?? System(id: 999, name: "Unknown", iconURL: "")
    }
    
    public static var mock: System {
        System(id: 6, name: "Game Boy", iconURL: "https://static.retroachievements.org/assets/images/system/gb.png")
    }
    
    public static var all: [System] {
        [
            System(id: 4, name: "Game Boy", iconURL: "https://static.retroachievements.org/assets/images/system/gb.png"),
            System(id: 6, name: "Game Boy Color", iconURL: "https://static.retroachievements.org/assets/images/system/gbc.png"),
            System(id: 5, name: "Game Boy Advance", iconURL: "https://static.retroachievements.org/assets/images/system/gba.png"),
            System(id: 7, name: "NES/Famicom", iconURL: "https://static.retroachievements.org/assets/images/system/nes.png"),
            System(id: 3, name: "SNES/Super Famicom", iconURL: "https://static.retroachievements.org/assets/images/system/snes.png"),
            System(id: 2, name: "Nintendo 64", iconURL: "https://static.retroachievements.org/assets/images/system/n64.png"),
            System(id: 18, name: "Nintendo DS", iconURL: "https://static.retroachievements.org/assets/images/system/ds.png"),
            System(id: 78, name: "Nintendo DSi", iconURL: "https://static.retroachievements.org/assets/images/system/dsi.png"),
            System(id: 24, name: "Pokemon Mini", iconURL: "https://static.retroachievements.org/assets/images/system/mini.png"),
            System(id: 28, name: "Virtual Boy", iconURL: "https://static.retroachievements.org/assets/images/system/vb.png"),
            System(id: 12, name: "PlayStation", iconURL: "https://static.retroachievements.org/assets/images/system/ps1.png"),
            System(id: 21, name: "PlayStation 2", iconURL: "https://static.retroachievements.org/assets/images/system/ps2.png"),
            System(id: 41, name: "PlayStation Portable", iconURL: "https://static.retroachievements.org/assets/images/system/psp.png"),
            System(id: 25, name: "Atari 2600", iconURL: "https://static.retroachievements.org/assets/images/system/2600.png"),
            System(id: 51, name: "Atari 7800", iconURL: "https://static.retroachievements.org/assets/images/system/7800.png"),
            System(id: 17, name: "Atari Jaguar", iconURL: "https://static.retroachievements.org/assets/images/system/jag.png"),
            System(id: 77, name: "Atari Jaguar CD", iconURL: "https://static.retroachievements.org/assets/images/system/jcd.png"),
            System(id: 13, name: "Atari Lynx", iconURL: "https://static.retroachievements.org/assets/images/system/lynx.png"),
            System(id: 33, name: "SG-1000", iconURL: "https://static.retroachievements.org/assets/images/system/sg1k.png"),
            System(id: 11, name: "Master System", iconURL: "https://static.retroachievements.org/assets/images/system/sms.png"),
            System(id: 15, name: "Game Gear", iconURL: "https://static.retroachievements.org/assets/images/system/gg.png"),
            System(id: 1, name: "Genesis/Mega Drive", iconURL: "https://static.retroachievements.org/assets/images/system/md.png"),
            System(id: 9, name: "Sega CD", iconURL: "https://static.retroachievements.org/assets/images/system/scd.png"),
            System(id: 10, name: "Sega 32X", iconURL: "https://static.retroachievements.org/assets/images/system/32x.png"),
            System(id: 39, name: "Sega Saturn", iconURL: "https://static.retroachievements.org/assets/images/system/sat.png"),
            System(id: 40, name: "Sega Dreamcast", iconURL: "https://static.retroachievements.org/assets/images/system/dc.png"),
            System(id: 8, name: "PC Engine/TurboGrafx-16", iconURL: "https://static.retroachievements.org/assets/images/system/pce.png"),
            System(id: 76, name: "PC Engine CD/TurboGrafx-CD", iconURL: "https://static.retroachievements.org/assets/images/system/pccd.png"),
            System(id: 47, name: "PC-8000/8800", iconURL: "https://static.retroachievements.org/assets/images/system/8088.png"),
            System(id: 49, name: "PC-FX", iconURL: "https://static.retroachievements.org/assets/images/system/pc-fx.png"),
            System(id: 56, name: "Neo Geo CD", iconURL: "https://static.retroachievements.org/assets/images/system/ngcd.png"),
            System(id: 14, name: "Neo Geo Pocket", iconURL: "https://static.retroachievements.org/assets/images/system/ngp.png"),
            System(id: 43, name: "3DO Interactive Multiplayer", iconURL: "https://static.retroachievements.org/assets/images/system/3do.png"),
            System(id: 37, name: "Amstrad CPC", iconURL: "https://static.retroachievements.org/assets/images/system/cpc.png"),
            System(id: 38, name: "Apple II", iconURL: "https://static.retroachievements.org/assets/images/system/a2.png"),
            System(id: 27, name: "Arcade", iconURL: "https://static.retroachievements.org/assets/images/system/arc.png"),
            System(id: 73, name: "Arcadia 2001", iconURL: "https://static.retroachievements.org/assets/images/system/a2001.png"),
            System(id: 71, name: "Arduboy", iconURL: "https://static.retroachievements.org/assets/images/system/ard.png"),
            System(id: 44, name: "ColecoVision", iconURL: "https://static.retroachievements.org/assets/images/system/cv.png"),
            System(id: 75, name: "Elektor TV Games Computer", iconURL: "https://static.retroachievements.org/assets/images/system/elek.png"),
            System(id: 57, name: "Fairchild Channel F", iconURL: "https://static.retroachievements.org/assets/images/system/chf.png"),
            System(id: 45, name: "Intellivision", iconURL: "https://static.retroachievements.org/assets/images/system/intv.png"),
            System(id: 74, name: "Interton VC 4000", iconURL: "https://static.retroachievements.org/assets/images/system/vc4000.png"),
            System(id: 23, name: "Magnavox Odyssey 2", iconURL: "https://static.retroachievements.org/assets/images/system/mo2.png"),
            System(id: 69, name: "Mega Duck", iconURL: "https://static.retroachievements.org/assets/images/system/duck.png"),
            System(id: 29, name: "MSX", iconURL: "https://static.retroachievements.org/assets/images/system/msx.png"),
            System(id: 80, name: "Uzebox", iconURL: "https://static.retroachievements.org/assets/images/system/uze.png"),
            System(id: 46, name: "Vectrex", iconURL: "https://static.retroachievements.org/assets/images/system/vect.png"),
            System(id: 72, name: "WASM-4", iconURL: "https://static.retroachievements.org/assets/images/system/wasm4.png"),
            System(id: 63, name: "Watara Supervision", iconURL: "https://static.retroachievements.org/assets/images/system/wsv.png"),
            System(id: 53, name: "WonderSwan", iconURL: "https://static.retroachievements.org/assets/images/system/ws.png")
        ]
    }
}

