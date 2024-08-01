# simple_quiver_leaderboard
This project is a demonstration of setting up a simple "Top 10" leaderboard for a Godot 4 project (Built in Godot 4.3 beta 3). 

We provide an overview to this project on our [blog](https://open.substack.com/pub/artemoosegames/p/make-a-public-leaderboard-in-godot). 

Steps -

1. Set up your Quiver Leaderboard Project on the [Quiver website
](https://quiver.dev/leaderboards/).

2. Add Quiver Leaderboards and Quiver Player Accounts Plugins to your project and enable them in your godot project settings. They are already installed in this demo project, but you will need to do this on your own if working in another project. See instructions [here](https://github.com/quiver-dev/quiver-leaderboards-godot-plugin?tab=readme-ov-file#quiver-leaderboards). 

3. Get your Token and Leaderboard ID from your Quiver Leaderboard project settings. If running this demo project directly, you'll need to add the Token to the project settings and add the leaderboard id to the top of the `leaderboard.gd` script under `LEADERBOARD_ID`.

This is all you should need to do in this project to test it out as is. 

Disclaimer: Artemoose Games, LLC is not affiliated with [Quiver](https://quiver.dev/). We are just fans of their product and wanted to share our simple implementation of a leaderboard using the Quiver leaderboards API, which is free to use for small projects. 

All visual assets and fonts in this demo project are from [Kenney.nl](https://kenney.nl/assets/ui-pack).