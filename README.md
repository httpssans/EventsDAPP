# Events DApp
A decentralized application (DApp) for managing event RSVPs on the Ethereum blockchain. Users can create events with voting options and images, RSVP with a 0.1 ETH fee, and view event details transparently. Built with Solidity, React, Tailwind CSS, Web3.js, and Vite.

## Features

Event Creation: Organizers can create events with a name, voting options (e.g., genres, topics), and an image (local or uploaded).
RSVP System: Users RSVP to events by paying 0.1 ETH, with a single RSVP per user per event ("See you there!" confirmation).
Dynamic UI: Displays connected account, event details, and RSVP status in a responsive, white-box design with a sticky navbar.
Image Support: Preloaded events use images from src/images, served via Vite alias; user-uploaded images use temporary blob: URLs.
Blockchain Transparency: All event data (name, creator, voting options, image URL) is stored on-chain for trustless access.

## Prerequisites
To run this project locally, we'll need:

Node.js (v16 or later)
npm (included with Node.js)
MetaMask browser extension
Ganache for a local Ethereum blockchain
Truffle (npm install -g truffle)
A terminal (e.g., PowerShell, Git Bash, or any Unix shell)

## Setup Instructions
### 1. Clone the Repository
```bash
git clone https://github.com/httpssans/EventsDAPP.git
cd EventsDApp
```

### 2. Install Dependencies
Install project dependencies (Vite, Web3.js, etc.)
```bash
npm install
```


### 3. Verify images:
```bash
dir src/images
```
(Common error for me)

### 4. Start Ganache
Launch Ganache with:

### Network ID: 1337
### Port: 7545
### Gas Limit: 6721975
### Hardfork: MERGE

Change in settings if needed

Keep Ganache running to simulate the Ethereum blockchain.
### 5. Compile the Contract
```bash
truffle compile
```

Output should show:
Compiling .\contracts\EventRSVP.sol
Artifacts written to .\build\contracts

### 6. Deploy the Contract
```bash
truffle migrate --reset
```

The migration script (migrations/2_deploy_contracts.js) creates three preloaded events with images at /images/wothy.jpeg, /images/patil.jpg, /images/upbars.jpg.

### 7. Update Frontend
Update src/index.html with the contract address:

Open src/index.html.
Find:const contractAddress = "0xNewContractAddress";
    transaction hash:    0xTransaction
    Blocks: 0            Seconds: 0
   == contract address:    <u>0xNewContractAddress<u> ==
    block number:        3
    block timestamp:     1745605789
    account:             0xNewAccountAddress
    balance:             99.993537021205562804
    gas used:            1746123 (0x1aa4cb)
    gas price:           3.177688086 gwei
    value sent:          0 ETH
    total cost:          0.005548634253790578 ETH
Copy the deployed EventRSVP contract address (e.g., 0xNewContractAddress) from the output.
Replace with the actual address from truffle migrate --reset.

### 8. Start the Frontend
```bash
npm run dev
```

Open http://localhost:3000 in your browser.
Vite serves images from src/images at /images/... (e.g., http://localhost:3000/images/wothy.jpeg).

### 9. Connect MetaMask

Open MetaMask in your browser.
Add a custom network:
Network Name: Ganache
RPC URL: http://127.0.0.1:7545
Chain ID: 1337
Currency Symbol: ETH


Import a test account from Ganache:
In Ganache, copy a private key from the Accounts tab.
In MetaMask, select Import Account and paste the private key.


Ensure the account has ~100 ETH (provided by Ganache).

## Usage
Organizer (Any Account)

### Create Event:
Enter an event name (e.g., "Test Event").
Add voting options (comma-separated, e.g., "Option1,Option2").
Upload an image (.jpg or .png).
Click Create Event and approve the transaction in MetaMask.
The image uses a temporary blob: URL (persists until page reload).


### View Events:
Click Fetch Events to see all events, including preloaded ones with images from src/images.



## Guests (Any Account)

### RSVP to Events:
Click RSVP (0.1 ETH) for an event.
Approve the 0.1 ETH transaction in MetaMask.
The button changes to "See you there!" and becomes disabled (single RSVP enforced).


### View Details:
See event name, creator, RSVP fee, voting options, and image (if available).



## Notes

### Preloaded Events:
"Wothy Concert Night" (Rock, Pop, Jazz)
"Patil Tech Meetup" (AI, Blockchain, Cloud)
"Upbars Art Exhibition" (Modern, Classic, Abstract)


### Images:
Preloaded event images are served from src/images via a Vite alias (/images).
User-uploaded images use blob: URLs, which expire on page reload.


### UI:
White box design with black text and gray accents.
Sticky navbar with "Events DApp" title and connected account (e.g., 0x1234...5678).
Sliding buttons with black hover effect.



## Troubleshooting
### Images Not Loading

Check src/images:dir src\images

Verify Vite Config:Confirm vite.config.js has:alias: { '/images': path.resolve(__dirname, 'src/images') }


Test URLs:Open http://localhost:3000/images/wothy.jpeg in the browser.
Contract Paths:In Truffle console:truffle console
let contract = await EventRSVP.deployed()
let events = await contract.getAllEvents()
console.log(events)

Verify imageUrl fields: /images/wothy.jpeg, etc.
Clear Cache:Ctrl+Shift+Delete # Clear browser cache
```bash
npm run dev
```


## MetaMask Errors

Ensure the network is Ganache (Chain ID 1337, RPC http://127.0.0.1:7545).
Verify the account has ETH (import a Ganache account).

## Contract Errors

Redeploy after contract changes:truffle migrate --reset


Update src/index.html with the new address.

## Console Logs

Check F12 > Console for errors (e.g., 404 for images).
Look for Fetched events: to confirm contract data.

## Development

Smart Contract:
Edit contracts/EventRSVP.sol for logic changes.
Update migrations/2_deploy_contracts.js for preloaded events.


## Frontend:
Modify src/index.html (single-file React with JSX).
Adjust Tailwind CSS classes for styling.
Add features in the <script type="text/babel"> section.


## Images:
Add new images to src/images and update 2_deploy_contracts.js.
Ensure vite.config.js aliases are correct.


## Production:
Host images on IPFS/CDN for persistent URLs.
Run npm run build and npm run preview to test the production build.

## Contributing

Fork the repository.
Create a feature branch (git checkout -b feature/YourFeature).
Commit changes (git commit -m "Add YourFeature").
Push to the branch (git push origin feature/YourFeature).
Open a Pull Request.

## License
MIT License. See LICENSE for details.
## Contact
For questions, open an issue or contact @httpssans.
