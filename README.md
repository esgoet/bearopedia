# Bearopedia - iPhone Multi-Screen App

With the app 'Bearopedia', the user can get information about the different bear species that exist around the world.
For that purpose, they can first choose out of a selection of all the bear species of which they want to have a closer look at.
If they'd like they can also show which bear species they like the most by favouriting them, and, in a separate section for favourited species, rank them.
After selecting a bear, the user can investigate the species appearance through a large photograph, and get a fun fact about the species.
Then, they can get more factual information about the bear species, and ultimately the user will be led to the wikipedia page of the species.
The user can also customise their app experience by clicking on the setting button on the first screen, which allows changing the theme between light and dark, and 'bearifying' the table of species.

The app was built on iPhone 11. With the set constraints, a good experience should be possible on any iPhone model, but to ensure the best user experience, the app should be run on an iPhone 11 as well.
Using dark mode is recommended!

Special features and technical contributions:
* Self-made bear app icon and bear claw symbol (validated with Apple's SF symbols application) to show the theme of the app
* Launch Screen that features the icon and name of the app
* Pop-up views for both the settings on the first screen and the fun fact on the second screen with modal presentation and transition styles
* Implementation of Tap Gesture Recognition so that tapping outside of the pop-up views closed them additionally to the close button within them, as this is a common feature within mobile apps
* Additional features on the web view such as refreshing the page, going backwards and forwards if possible, allowing to exit the app and load the same url in safari
* Progress bar connected with the web view by adding an observer to its estimated progress with a key path to show the progress of loading a url, that hides after a second once the website has finished loading
* Additional functionality for the search bar connected to the web view:
    * Change from white to grey once editing of the text field has stopped to show this to the user
    * O nly enable the clear button when not editing so that it does not cover the any part of the small area of text
    * If empty when editing has finished or when trying to load the website, the url of the current website will be displayed so no error occurs and the user can still see the url for the website they are on
* Loading of multiple habitats for each species through parsing an xml list into an array as part of the Species class
* Displaying of these habitats in an additional table view that is within a view whose height constraint is optimally adjusted based on the number of habitats to ensure that all habitats are visible
* Implementation of a scroll view with a stack view for the additional facts: even if the content is bigger than the screen due to the number of habitats, the user can simply scroll the whole stack view
* Custom table view cell class for more control over the design, including adding a like button, an image, and, if the 'bearify' switch is switched in the settings, a mask and border in form of a bear for the image
* Use of table view delegate to customise view for the header for sections
* Like buttons in each table view cell and the bear overview that allows to 'favourite' the bear species, which communicate to the data source with notifications so that it is always up-to-date
* Tab bar connected to table view to allow to only see the favourited species, which can be ranked by dragging and dropping the cells, for which the rank displayed will automatically update
* Bearify switch state communicated from the settings view controller to custom table view cells via notification
* Can choose between dark and light mode when going to the settings (upper button on first screen), which is applied to the whole app
* Custom colour sets within the assets, which are also used to differentiate between dark and light mode and achieve uniform design through colours
* Uniform design between screens otherwise achieved by deciding to use rounded corners and applying some transparency throughout
