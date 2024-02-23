// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract VotingPoll {
    // Variables to store poll data
    uint256 newPoll;
    address owner;
    uint256 year;
    uint256 registeredVoters;
    string numberOfParty;
    string numberOfContestants;
    bool hasVoted = true;

    // Struct to store poll information
    struct Polls {
        uint256 year;
        uint256 registeredVoters;
        string numberOfParty;
        string numberOfContestants;
    }

    Polls[] pollsArr; // Array to store polls

    // Struct to store contestant information
    struct Contestant {
        string name;
        string party;
        string position;
        uint256 voteCount;
    }

    bool isPresent = true;
    Contestant[] contestantArr; // Array to store contestants

    mapping(address => uint256) voter; // Mapping to track voters

    // Constructor to set the owner of the contract
    constructor(address owner) {
        require(owner == msg.sender, "Failed to call this operation. Check the address");
        owner = msg.sender; // Assigning the owner
    }

    // Function to create a new poll
    function createPoll(uint256 _year, uint256 _registeredVoters, string memory _numberOfParty, string memory _numberOfContestants) external {
        // Creating a new poll instance
        Polls memory newPollCreated = Polls({
            year: _year,
            registeredVoters: _registeredVoters,
            numberOfParty: _numberOfParty,
            numberOfContestants: _numberOfContestants
        });

        pollsArr.push(newPollCreated); // Adding the new poll to the array
    }

    // Function for casting a vote
    function voteCasting(address _voter, string memory _name, string memory _party, string memory _position) external {
        // Checking if the voter is eligible and hasn't voted already
        require(_voter == msg.sender, "You cannot vote");
        require(hasVoted == false, "You have already voted before");

        // Iterating through contestants to find the matching one
        for (uint256 i = 0; i < contestantArr.length; i++) {
            if (keccak256(bytes(contestantArr[i].name)) == keccak256(bytes(_name)) &&
                keccak256(bytes(contestantArr[i].party)) == keccak256(bytes(_party)) &&
                keccak256(bytes(contestantArr[i].position)) == keccak256(bytes(_position))) {
                
                contestantArr[i].voteCount++;  //Incrementing the vote count for the contestant
                hasVoted = true; // Marking the voter as voted
                break;
            }
        }
    }

    // Function to get all polling events
    function pollingEvents() external view returns (Polls[] memory) {
        return pollsArr;
    }

    // Function to get poll results
    function showPollResult() external view returns (Contestant[] memory) {
        return contestantArr;
    }
}
