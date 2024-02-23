// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;
import './VotingPoll.sol';

contract VotingPollFactory {

    VotingPoll[] voteInstance;

    event PollCreated(address indexed pollAddress, address indexed owner);


    function createVotingPoll(address _owner) external returns(VotingPoll newPoll, uint256 _id) {
        newPoll = new VotingPoll(_owner);
        voteInstance.push(newPoll);
        _id = voteInstance.length;
        emit PollCreated(address(newPoll), _owner);
        return (newPoll, _id);
    }

    function getAllPolls() external view returns(VotingPoll[] memory) {
        return voteInstance;
    }
}