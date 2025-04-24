pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

contract EventRSVP {
    uint256 public constant RSVP_FEE = 0.1 ether;
    uint256 public eventCount;

    struct Event {
        string name;
        address creator;
        uint256 rsvpFee;
        string[] votingOptions;
        string imageUrl;
    }

    mapping(uint256 => Event) public events;
    mapping(uint256 => string[]) public votingOptions;
    mapping(uint256 => mapping(address => bool)) public hasRSVPed;

    event EventCreated(uint256 eventId, string name, address creator, string imageUrl);
    event RSVPConfirmed(uint256 eventId, address attendee);

    constructor() public {
        eventCount = 0;
    }

    function createEvent(string memory _name, string[] memory _votingOptions, string memory _imageUrl) public {
        require(bytes(_name).length > 0, "Event name cannot be empty");
        require(_votingOptions.length > 0, "At least one voting option required");
        eventCount++;
        events[eventCount] = Event(_name, msg.sender, RSVP_FEE, _votingOptions, _imageUrl);
        votingOptions[eventCount] = _votingOptions;
        emit EventCreated(eventCount, _name, msg.sender, _imageUrl);
    }

    function rsvp(uint256 _eventId) public payable {
        require(_eventId > 0 && _eventId <= eventCount, "Invalid event ID");
        require(msg.value == RSVP_FEE, "Incorrect RSVP fee");
        require(!hasRSVPed[_eventId][msg.sender], "Already RSVPed for this event");
        hasRSVPed[_eventId][msg.sender] = true;
        emit RSVPConfirmed(_eventId, msg.sender);
    }

    function getAllEvents() public view returns (Event[] memory) {
        Event[] memory allEvents = new Event[](eventCount);
        for (uint256 i = 0; i < eventCount; i++) {
            allEvents[i] = events[i + 1];
        }
        return allEvents;
    }

    function getEventDetails(uint256 _eventId) public view returns (string memory, address, uint256, string[] memory, string memory) {
        require(_eventId > 0 && _eventId <= eventCount, "Invalid event ID");
        Event memory evt = events[_eventId];
        return (evt.name, evt.creator, evt.rsvpFee, evt.votingOptions, evt.imageUrl);
    }

    function eventFunds(uint256) public view returns (uint256) {
        return address(this).balance;
    }

    function hasUserRSVPed(uint256 _eventId, address _user) public view returns (bool) {
        return hasRSVPed[_eventId][_user];
    }
}