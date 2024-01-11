# Sing


Steps

- add assets/js/hooks/audio_mp3.js
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


Notes:
- In a real application, could use Ecto schemas to validate the input and limits. Keeping it simple.

