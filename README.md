# RedServer - A minecraft server manager
Want to run a paper server?

### Dependicies and Running

#### Dependicies:
- Ruby

##### Gem modules:
// May come by default
- FileUtils
- JSON
- Open-Uri

// Need to install
- Colorize

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
