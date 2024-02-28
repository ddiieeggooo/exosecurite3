function vote(uint proposalId) public flowStatus(WorkflowStatus.VotingSessionStarted) {
        require(voters[msg.sender].isRegistered, "You are not allowed to vote");
        require(!voters[msg.sender].hasVoted, "You have already voted");
        proposals[proposalId].voteCount += 1;
        voters[msg.sender].hasVoted = true;
        voters[msg.sender].votedProposalId = proposalId;

        if (proposals[proposalId].voteCount > proposals[winningProposalId].voteCount) {
            winningProposalId = proposalId;
        }

        emit Voted(msg.sender, proposalId);
    }

// ANOTHER SOLUTION : cap the number of proposals to prevent gas limit attack

function registerProposals(string memory proposalDescription) public flowStatus(WorkflowStatus.ProposalsRegistrationStarted) {
        require(voters[msg.sender].isRegistered, "You are not allowed to make a proposal");
        // cap the number of proposals to prevent gas limit attack
        require(proposals.length<1000);
        proposals.push(Proposal(proposalDescription, 0));
        voters[msg.sender].votedProposalId = proposals.length + 1;
    }
