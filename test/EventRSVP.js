const EventRSVP = artifacts.require("EventRSVP");

contract("EventRSVP", accounts => {
  let eventRSVP;

  beforeEach(async () => {
    eventRSVP = await EventRSVP.new();
  });

  it("should create an event", async () => {
    await eventRSVP.createEvent("Test Event", ["Option1", "Option2"], { from: accounts[0] });
    const event = await eventRSVP.getEventDetails(1);
    assert.equal(event[0], "Test Event", "Event name should match");
    assert.equal(event[1], accounts[0], "Creator should match");
    assert.equal(event[2].toString(), web3.utils.toWei("0.1", "ether"), "RSVP fee should be 0.1 ETH");
  });

  it("should allow RSVP with correct fee", async () => {
    await eventRSVP.createEvent("Test Event", ["Option1"], { from: accounts[0] });
    await eventRSVP.rsvp(1, { from: accounts[1], value: web3.utils.toWei("0.1", "ether") });
    const rsvpStatus = await eventRSVP.rsvps(1, accounts[1]);
    assert.equal(rsvpStatus, true, "RSVP should be recorded");
  });

  it("should reject RSVP with incorrect fee", async () => {
    await eventRSVP.createEvent("Test Event", ["Option1"], { from: accounts[0] });
    try {
      await eventRSVP.rsvp(1, { from: accounts[1], value: web3.utils.toWei("0.05", "ether") });
      assert.fail("RSVP should have failed");
    } catch (error) {
      assert(error.message.includes("revert"), "Expected revert for incorrect fee");
    }
  });
});