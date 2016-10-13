This is Reddit Wallpapers by Danny Peng

Authors Note:

This app parses json from https://www.reddit.com/r/wallpapers/ using the open source framework SwiftyJSON available at https://github.com/SwiftyJSON/SwiftyJSON. I could have used the built in NSJSONSerialization in UIKit for this project but I thought i'd have fun with it and try out SwiftyJSON for the first time and it was exciting to work with!

I installed SwiftyJSON using Cocoa Pods and I also had the hopes of incorporating a Firebase Login as well to allow users to like and dislike certain wallpapers storing responses to firebase. However, I did not get to that due time constraints with school and work. I actually focused more of my time on trying to do a continuous stream of images by parsing an extention to the url to get the next set of JSON and extracting urls. I was sucessful in that attempt but I ran into a problem with memory. This part is unfinished. The next button on my app would have shown you more images but it crashes due to available memory issues so instead I turned it into a nice scroll to top button for the users sake of not having to scroll a few times to get to the top. I had a fix in mind for the next pages but not enough time to apply it. I would go about it by storing the image urls and clear my collection view and reload the new images if next was pressed.

I am also aware that while the device is in airplane mode it will not work and will not load in the files no matter how long you wait. This is an issue I found last minute that I did not have enough time to look into. I would like the reader to know I was mindful of this case.

Description: This App parses JSON code from https://www.reddit.com/r/wallpapers/ and it downloads and presents the top 25 wallpapers to be displayed to the user in descending order starting at number 25. Initially the program will load a placeholder image and once images load in they will be replaced. Upon selecting the image the user may chose to save the photo using the save button. I also incorportated social features using the Social framework to post directly to facebook and twitter. The app would have parse a complete stream but I ran into issues that I did not have time to resolve so rather all reddit wallpapers, I turned it into the Top 25 Wallpapers! The next button in the right corner of the app would have scrolled atop the collection view and replace the images with the next set of images but implementation was incomplete here. So instead it allows you to scroll back to the top!

Challenges I faced:
1. Initially App crashed because my Collection View was empty and it took a long time for images to download.
Solution: Placeholders that kind of act like loading images that would be replaced once image loads up.
2. There was a case where the parse JSON code did not contain a url to download image due to the face two people posted questions rather than images and the post contains no image causing the program to crash
Solution: Checked for this and whenever someone made a post that does not have a image, then we show the image "No Image Available" (see attached image)
3. Finally when I used SwiftyJSON, I had an issue that made the program crash. I applied a weird fix suggested from the debugger to allow app transport setting to be configured for the purposes of this app.
Solution: Change some of the target properties. Allow certain websites such as reddit wallpapers through.






