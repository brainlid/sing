# Sing

A Phoenix LiveView demo application showing how to add sound effects to a LiveView page. Sound effects are linked to button clicks and played locally in the browser, while other sound effects can be triggered by the server.

The solution uses the [Howler.js](https://www.npmjs.com/package/howler) library in the browser, making it a mobile friendly solution as well.

## Demo Video

Check out the demo video to see what it does. Make sure your sound is turned on!

![Sound effect demo](phoenix-sound-effect-demo.mp4)

## Steps to duplicate

The following is a rough outline of the steps taken to add this approach to a project.

- add `assets/js/hooks/audio_mp3.js`
- updated app.js to load hooks
- add Howler from npm
  - `cd assets; npm i howler` adds to `package.json`
- `mix esbuild.install`
- add HTML code for hook to page, output sounds in HTML `data-sounds`
- add `assign_sounds` to mount in LiveView
- add `priv/static/audio/` and some audio files.
- update `lib/sing_web.ex` to add `audio` to the list
- add code in `index.ex`
- add delayed sound event pushed from server.


**Notes:**
- In a real application, could use Ecto schemas to validate the input and limits. Keeping it simple.

