// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.5;

contract Voting {
    address public owner;
    uint256 public VoteCount = 0;

    constructor() {
        owner == msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Not owner");
        _;
    }

    modifier onlyRegisteredVoters() {
        require(CheckIfUserisRegistere(msg.sender), "Create An Account");
        _;
    }
    struct VotersInfo {
        address Registeredvoter;
        string name;
        bool isvoted;
    }

    struct AllregisteredVoters {
        address Registeredvoter;
        string name;
    }

    AllregisteredVoters[] allVoters;

    mapping(address => VotersInfo) public votersinfo;
    event registered(string indexed name);
    event Voted(address indexed voter);

    function Register(string calldata name) public {
        require(
            CheckIfUserisRegistere(msg.sender) == false,
            "User Already Exist"
        );
        require(bytes(name).length > 0, "Invalid Name");
        votersinfo[msg.sender].name = name;
        allVoters.push(AllregisteredVoters(msg.sender, name));
        emit registered(name);
    }

    // Only the contract owner can add More than one voters
    function RegisterVoters(string calldata name) public onlyOwner {
        require(
            CheckIfUserisRegistere(msg.sender) == false,
            "User Already Exist"
        );
        require(bytes(name).length > 0, "Invalid Name");
        votersinfo[msg.sender].name = name;
        allVoters.push(AllregisteredVoters(msg.sender, name));
        emit registered(name);
    }

    // Only the contract owner can add voters
    function registerVoters(
        address[] calldata addresses,
        string[] calldata names
    ) public onlyOwner {
        require(
            addresses.length == names.length,
            "Address and name arrays must have the same length"
        );

        for (uint256 i = 0; i < addresses.length; i++) {
            require(bytes(names[i]).length > 0, "Invalid Name");
            require(
                CheckIfUserisRegistere(addresses[i]) == false,
                "User Already Exist"
            );

            votersinfo[addresses[i]].name = names[i];
            allVoters.push(AllregisteredVoters(addresses[i], names[i]));

            emit registered(names[i]);
        }
    }

    function CheckIfUserisRegistere(address user) public view returns (bool) {
        return bytes(votersinfo[user].name).length > 0;
    }

    function Vote() public onlyRegisteredVoters {
        require(votersinfo[msg.sender].isvoted == false, "Already Voted");

        votersinfo[msg.sender].isvoted = true;
        VoteCount++;
        emit Voted(msg.sender);
    }

    function getCurrentVoteCount() public view returns (uint256) {
        return (VoteCount);
    }

    function getAllregisteredVoters()
        public
        view
        returns (AllregisteredVoters[] memory)
    {
        return allVoters;
    }
}
