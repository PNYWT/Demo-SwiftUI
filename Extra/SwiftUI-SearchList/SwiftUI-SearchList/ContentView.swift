//
//  ContentView.swift
//  SwiftUI-SearchList
//
//  Created by CallmeOni on 15/3/2568 BE.
//

import SwiftUI

struct ContentView: View {
    
    @State private var heroes: [String] = [
        "Iron Man",
        "Captain America",
        "Thor",
        "Hulk",
        "Black Widow",
        "Doctor Strange",
        "Spider-Man",
        "Black Panther",
        "Scarlet Witch",
        "Ant-Man",
        "Wolverine",
        "Deadpool",
        "Superman",
        "Batman",
        "Wonder Woman",
        "Flash",
        "Green Lantern",
        "Aquaman",
        "Shazam",
        "Cyborg",
        "Green Arrow",
        "Nightwing",
        "Daredevil",
        "Luke Cage",
        "Jessica Jones",
        "Punisher",
        "Ghost Rider",
        "Silver Surfer",
        "Hawkeye",
        "Star-Lord",
        "Gamora",
        "Drax",
        "Rocket Raccoon",
        "Groot",
        "Vision",
        "Quicksilver",
        "Falcon",
        "Winter Soldier",
        "Shang-Chi",
        "Moon Knight",
        "Ms. Marvel",
        "Captain Marvel",
        "Blue Beetle",
        "Doctor Fate",
        "Spawn",
        "Hellboy",
        "Elektra",
        "Iron Fist",
        "Nova",
        "Colossus",
        "She-Hulk"
    ]

    @State private var searchTerm = ""
    
    var filteredHeroes: [String] {
        guard !searchTerm.isEmpty else {
            return heroes
        }
        return heroes.filter { $0.lowercased().contains(searchTerm.lowercased()) }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if heroes.isEmpty {
//                    ContentUnavailableView("No Heroes", systemImage: "person.slash", description: Text("You need to create a hero to see it here."))
                    
                    ContentUnavailableView {
                        VStack(spacing: 16) {
                            ZStack {
                                Color.mint
                                    .clipShape(.circle)
                                Image(systemName: "person.slash")
                                    .resizable()
                                    .padding()
                            }
                            .frame(width: 100, height: 100)
                            
                            Text("No Heroes")
                                .bold()
                        }
                    } description: {
                        Text("You need to create a hero to see it here.")
                            .italic()
                            .foregroundStyle(.teal)
                    } actions: {
                        Button("Add Hero") {
                            
                        }
                        .buttonStyle(.bordered)
                    }

                } else {
                    List(filteredHeroes, id: \.self) { hero in
                        Text(hero)
                    }
                    .searchable(text: $searchTerm, prompt: "Search Hero")
                    .overlay {
                        if filteredHeroes.isEmpty {
                            ContentUnavailableView.search(text: searchTerm)
                        }
                    }
                }
            }
            .navigationTitle("Heroes")
        }
    }
}

#Preview {
    ContentView()
}
