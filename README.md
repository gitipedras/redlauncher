# RedServer - A minecraft launcher
Want to run a paper server?

### Running
To run redlauncher, you need ruby installed. You can install it by:
#### Homebrew
`brew install ruby`

##### APT
`sudo apt-get install ruby`

And finally to run it:
`ruby main.rb`

### Usage

#### Plugins
not supported

#### Auto Install
Configure `auto.json` to look like this:
```json
{
  "serverName": "Best TEST Server in the World", // Server name
  "serverVersion": "1.21.1", // Server version
  "eulaAccepted": true // Accept the eula?
}
```
