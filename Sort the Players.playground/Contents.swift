/*
   Treehouse iOS Tech Degree - Unit 01
   ===================================

   Project: Soccer League Coordinator
   Criteria Aimed For:  *Exceeds Expectations*
 
   Stephen McMillan
*/

import Foundation

/* Player Data
   ============
   Name, Height in Inches, Soccer Experience and Guardians
*/
let players = [["name": "Joe Smith",
                "height": "42",
                "hasSoccerExperience": "YES",
                "guardians": "Jim and Jan Smith"],
               
               ["name": "Jill Tanner",
                "height": "36",
                "hasSoccerExperience": "YES",
                "guardians": "Clara Tanner"],
               
               ["name": "Bill Bon",
                "height": "43",
                "hasSoccerExperience": "YES",
                "guardians": "Sara and Jenny Bon"],
               
               ["name": "Eva Gordon",
                "height": "45",
                "hasSoccerExperience": "NO",
                "guardians": "Wendy and Mike Gordon"],
               
               ["name": "Matt Gill",
                "height": "40",
                "hasSoccerExperience": "NO",
                "guardians": "Charles and Sylvia Gill"],
               
               ["name": "Kimmy Stein",
                "height": "41",
                "hasSoccerExperience": "NO",
                "guardians": "Bill and Hillary Stein"],
               
               ["name": "Sammy Adams",
                "height": "45",
                "hasSoccerExperience": "NO",
                "guardians": "Jeff Adams"],
               
               ["name": "Karl Saygan",
                "height": "42",
                "hasSoccerExperience": "YES",
                "guardians": "Heather Bledsoe"],
               
               ["name": "Suzane Greenberg",
                "height": "44",
                "hasSoccerExperience": "YES",
                "guardians": "Henrietta Dumas"],
               
               ["name": "Sal Dali",
                "height": "41",
                "hasSoccerExperience": "NO",
                "guardians": "Gala Dali"],
               
               ["name": "Joe Kavalier",
                "height": "39",
                "hasSoccerExperience": "NO",
                "guardians": "Sam and Elaine Kavalier"],
               
               ["name": "Ben Finkelstein",
                "height": "44",
                "hasSoccerExperience": "NO",
                "guardians": "Aaron and Jill Finkelstein"],
               
               ["name": "Diego Soto",
                "height": "41",
                "hasSoccerExperience": "YES",
                "guardians": "Robin and Sarika Soto"],
               
               ["name": "Chloe Alaska",
                "height": "47",
                "hasSoccerExperience": "NO",
                "guardians": "David and Jamie Alaska"],
               
               ["name": "Arnold Willis",
                "height": "43",
                "hasSoccerExperience": "NO",
                "guardians": "Claire Willis"],
               
               ["name": "Phillip Helm",
                "height": "44",
                "hasSoccerExperience": "YES",
                "guardians": "Thomas Helm and Eva Jones"],

               ["name": "Les Clay",
                "height": "42",
                "hasSoccerExperience": "YES",
                "guardians": "Wynonna Brown"],
               
               ["name": "Herschel Krustofski",
                "height": "45",
                "hasSoccerExperience": "YES",
                "guardians": "Hyman and Rachel Krustofski"]]
// End of Player Data

/*
 Sorting Logic
 =============
 Sort players based on experience. Players are shuffled before being sorted to create random teams each time.

 Sort on experience
 Assign experienced and inexperienced until there are none left.
 Compute the average height of each team.
 Carry out check to ensure that the difference between 2 teams does not exceed 1.5 inches
 If it does:
 Run assignment again.
 If it doesn't:
 Skip to letters.
*/

func createThreeTeamsFrom(players: (experienced: [[String: String]], inexperienced: [[String: String]])) -> (teamA: [[String: String]], teamB: [[String: String]], teamC: [[String: String]]) {
    
    var teamA: [[String: String]] = []
    var teamB: [[String: String]] = []
    var teamC: [[String: String]] = []
    
    func assignToTeam(players: [[String: String]]) {
        
        var counter = 0
        
        for player in players {
            
            switch counter {
            case 0: teamA.append(player)
            case 1: teamB.append(player)
            case 2: teamC.append(player)
            default: break
            }
            
            if counter == 2 {
                counter = 0
            } else {
                counter += 1
            }
        }
    }
    
    // Shuffling the players here means that the logic for repeat until avg height < 1.5 will work as expected
    assignToTeam(players: players.experienced.shuffled())
    assignToTeam(players: players.inexperienced.shuffled())

    return (teamA, teamB, teamC)
}

// Calculate and return the avergae height of a teams players
func calculateAverageHeight(ofTeam players: [[String:String]]) -> Double {

    var runningTotal = 0.0

    // Potentially a crash hotspot due to forced unwrapping
    for player in players {
        
        if let playerHeight = player["height"] {
            runningTotal += Double(playerHeight) ?? 0.0
        }
    }

    return runningTotal / Double(players.count)
}

// Returns TRUE if average height of each team is  less 1.5
func heightDifferenceIsFair(between teamA: [[String: String]], and teamB: [[String: String]]) -> Bool {
    let avgA = calculateAverageHeight(ofTeam: teamA)
    let avgB = calculateAverageHeight(ofTeam: teamB)

    // Compute the difference between the two averages to see if they are within the 1.5 inch limit
    if (avgA - avgB).magnitude < 1.5 {
        return true
    } else {
        return false
    }
}

// Function for generating team letters.
func generatePracticeLetters(forTeam team: (teamName: String, players: [[String: String]], practiseDate: String, practiseTime: String)) -> [String] {
    var letters: [String] = []
    
    for player in team.players {
        
        if let name = player["name"], let guardians = player["guardians"] {
            
            let playerLetter =
            """
            Dear \(guardians)
            We are pleased to inform you that \(name) has successfully secured a place in \(team.teamName).
            
            The first practise session for \(team.teamName) is scheduled to take place on \(team.practiseDate) at \(team.practiseTime). If your child is unable to attend on this date, please let us know as soon as possible. All neccessary equipment will be provided and the session will last approximetly 2 hours.
            
            We look forward to meeting \(name).
            
            Regards,
            - The Soccer League
            """
            
            letters.append(playerLetter)
        }
    }
    
    return letters
}
// End of Functions

// Three Teams
var teamDragons: [[String: String]] = []
var teamSharks: [[String: String]] = []
var teamRaptors: [[String: String]] = []

// League Players are sorted based on their experience
var leaguePlayers: (experienced: [[String: String]], inexperienced: [[String: String]]) = ([], [])

for player in players.shuffled() {
    if player["hasSoccerExperience"]?.uppercased() == "YES" {
        leaguePlayers.experienced.append(player)
    } else {
        leaguePlayers.inexperienced.append(player)
    }
}

repeat {
    let sortedPlayers = createThreeTeamsFrom(players: leaguePlayers)
    
    teamDragons = sortedPlayers.teamA
    teamSharks = sortedPlayers.teamB
    teamRaptors = sortedPlayers.teamC
    
    // While the height difference _IS NOT_ fair/within 1.5 between each team then rebalance the teams until this is the case.
} while !heightDifferenceIsFair(between: teamDragons, and: teamSharks) ||
    !heightDifferenceIsFair(between: teamDragons, and: teamRaptors) ||
    !heightDifferenceIsFair(between: teamSharks, and: teamRaptors)

print(
    """
    The Average Height of each team:
    - The Dragons: \(calculateAverageHeight(ofTeam: teamDragons)) inches.
    - The Sharks: \(calculateAverageHeight(ofTeam: teamSharks)) inches.
    - The Raptors: \(calculateAverageHeight(ofTeam: teamRaptors)) inches.
    """
)

// Associate the Practise Date/Time with the newly formed teams
let teams = [(teamName: "The Dragons", players: teamDragons, practiseDate: "March 17th", practiseTime: "1pm"),
             (teamName: "The Sharks", players: teamSharks, practiseDate: "March 17th", practiseTime: "3pm"),
             (teamName: "The Raptors", players: teamRaptors, practiseDate: "March 18th", practiseTime: "1pm")
]

// Once the teams are assigned, send the letters.
var letters: [String] = []
for team in teams {
    letters += generatePracticeLetters(forTeam: team)
}

for letter in letters {
    print("\n\(letter)")
}

letters.count
