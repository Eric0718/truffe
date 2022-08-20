//SPDX-License-Identifier: MIT

pragma solidity >0.8.0;

contract Voting{
    uint _candidateId;
    address _manager;
    uint _deadline = block.timestamp;
    string[] names = new string[](0); 
    mapping(string => uint) CandidateInfo;
    mapping(address => bool) alreadyVoted;

    constructor (){
        _manager = msg.sender;
        _deadline = block.timestamp + 1 weeks;
        _candidateId = 0;
    }

    function addCandidate(string memory name)public{
        require(block.timestamp <= _deadline);
        require(_manager == msg.sender,"Only manager can add candidate!");
        require(!candidateExist(name),"sister is already exist!");
        names.push(name);
    }

    function getCandidates() public view returns(string[] memory candidates){
        candidates = names;
    }

    function candidateExist(string memory _name)internal view returns(bool){
        bool exist = false;
        for (uint i = 0;i < names.length;i++){
            bytes memory aa = bytes(names[i]);
            bytes memory bb = bytes(_name);
        
            if (aa.length == bb.length){
                for (uint j = 0;j< aa.length;j++){
                    if (aa[j] == bb[j] && j == aa.length-1)
                        exist = true;
                }
            }
        }
        return exist;
    }

    modifier noVoted(address _addr) {
        require(!alreadyVoted[msg.sender],"Already voted!");
        _;
    }


    function vote(string memory name)public noVoted(msg.sender){
        require(block.timestamp <= _deadline);
        require(candidateExist(name),"sister is not exist!");
        CandidateInfo[name]++;
        alreadyVoted[msg.sender] = true;
    }

    function getVotes(string memory name) public view returns(uint){
        return CandidateInfo[name];
    }

    function Winner()public view returns(string memory,uint total){
        require(names.length >0);
        //require(block.timestamp > _deadline,"The voting is still open,can't get winner!");
        uint winnerId = 0;
        uint max = CandidateInfo[names[0]];
        for(uint i = 1;i < names.length;i++){
            if (max < CandidateInfo[names[i]]){
                max = CandidateInfo[names[i]];
                winnerId = i;
            }     
        }
        return (names[winnerId],max);
    }
}