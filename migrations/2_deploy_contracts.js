const EventRSVP = artifacts.require("EventRSVP");

module.exports = async function(deployer) {
  await deployer.deploy(EventRSVP);
  const instance = await EventRSVP.deployed();

  // Pre-created three sample events
  await instance.createEvent(
    "Sanskar Concert Night",
    ["Rock", "Pop", "Jazz"],
    "/images/wothy.jpeg"
  );
  await instance.createEvent(
    "Bikram Tech Meetup",
    ["AI", "Blockchain", "Cloud"],
    "/images/patil.jpg"
  );
  await instance.createEvent(
    "Kunwar Art Exhibition",
    ["Modern", "Classic", "Abstract"],
    "/images/upbars.jpg"
  );
};