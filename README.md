# Mathy Friends

## Video Example
https://github.com/IanGaplichnik/Mathy_Friends/assets/70972514/a4fce768-9c63-4851-bf9f-3e8c4f6798ad



## Summary
Mathy Friends is an iOS application, that allows you to practice multiplication tables.<br>
Application is built using SwiftUI from a prototype in Figma (you can find .fig in the root) made by me.<br>
Animations were added to improve User Experience and bring additional functionality to the application.

## Visual and Game Design
### General
Mathy Friends target audience is primary school students, who need to practice multiplications.<br>
I've used Figma Community template "Book Template with Fuzzy Friends Illustrations" to build the UI and background.<br>
Bright but soft colors picked from template palette make this application more appealing to the younger users but does not distract from the tasks.<br>
Background picture is a collage made using templates.<br>
https://www.figma.com/community/file/984024125873977389

### Starting screen
<img width="324" alt="StartScreen" src="https://github.com/IanGaplichnik/Mathy_Friends/assets/70972514/d2cbf82b-3a61-49d3-9ba9-3ba842fc1e51">
<br>
Starting screen greets users with large logo printed with light font.<br>
User input section is accented and separated with a logical block, which calls to action and unites different input section.s<br>
Here user can choose which table they want to practice (table "5" would ask user to solve questions "5 x ... = ...") and amount of questions they want to answer.<br>
Menu picker and segmented picker are used for both fields, as it restricts user from entering information in the wrong format.

### Game screen
<img width="324" alt="MainScreen" src="https://github.com/IanGaplichnik/Mathy_Friends/assets/70972514/76dc7889-89ef-4346-9ddb-ce3c6e8ba85a">
<br>
As the game starts "Total score" appears on the top of the screen. Player is given a point for each correct answer.<br>
If player has chosen to answer 5 questions it is guaranteed, that questions won't repeat.<br>
The problem is displayed in the middle of the screen and user is given 4 answers. One of the answers is guaranteed to be correct, the rest are wrong.<br>
All provided answers are within +/-10 range around the correct answer, which makes it a bit more tricky to answer, reducing the chance of lucky guess, or having some nonsense generated answers (such as 2x2 = 1000; 71928; 12384; 4)<br>
Answer is given by pressing the corresponding button. After the button was pressed, user will see an animation - buttons will change the colors.<br> If button contains correct answer, it'll turn green,
otherwise, it'll turn red. The answer, that was picked by the user is lower, than the rest of the buttons. This way the user is able to verify, if they've picked the correct answer.
After the button was pressed, all buttons except "Next" (or "Finish", if it was the last question) are deactivated. This way user is not able to change their answer after seeing the correct one.

### Final alert
<img width="324" alt="AlertScreen" src="https://github.com/IanGaplichnik/Mathy_Friends/assets/70972514/8431ced9-8354-46c7-82c5-787ae0b13bc2">
<br>
After user has answered all questions, they will see an alert, notifying them of their final score. After that the game is restarted and user can pick new table or complete more exercices.
