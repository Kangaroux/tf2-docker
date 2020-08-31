# TF2 for Docker
This repo contains a Docker setup for automatically downloading, updating, and running a TF2 server.

## Quickstart
The first thing you should do is to run the server as-is to make sure it's working properly.

Run `./tf2.sh` to download and start the server. Once the download has completed, you should see the message ` >> Starting server`. If you're running this on your local machine you should also see the server appear under the LAN tab of the server browser.

The server files are in a `data/` directory. You'll probably want `data/tf/` which has things like `cfg`, `maps`, etc.

## Server Configuration
You can customize the server startup options with a `server.env` file. These are command line options used by SRCDS. For a full list of possible options see the [wiki page](https://developer.valvesoftware.com/wiki/Command_Line_Options#Source_Dedicated_Server).

### Options
- `SERVER_TOKEN`
	- A login token for your server, required by Steam. [Get a login token here.](https://steamcommunity.com/dev/managegameservers)
- `IP`
	- The IP to bind the server to. Leave this blank unless you know what you're doing. (default: `0.0.0.0`)
- `PORT`
	- The port to bind the server to. (default: `27015`)
- `START_MAP`
	- The map to load when the server starts. (default: `ctf_2fort`)
- `MAX_PLAYERS`
	- The maximum number of players for the server. (default: 16, max is 32)
- `VAC`
	- Enable/disable Valve Anti-Cheat. (default: `1`, use `0` for insecure)
- `DEBUG`
	- Enable/disable debugging. (default: `0`, use `1` to enable)
- `EXTRA`
	- Any extra command line options. These are appended to the end of the options before starting the server.

## Troubleshooting
- **The server crashes on startup and says to enable debugging for more info**
	- Open `docker/Dockerfile` and uncomment the debug section
	- Add `DEBUG=1` to `server.env`
	- Run `./tf2.sh`
	- Once you've solved the issue you can re-comment the debug section in the Dockerfile