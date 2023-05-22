# KommunicateAssignment

## Assignment Approach Documentation

### Introduction
This documentation provides an explanation of the approach taken to integrate communication in a sample app. The integration involved the use of Firebase and Kommunicate SDKs for authentication, storing user information, and enabling chat functionality. The app was built using SwiftUI and Swift Package Manager was used to manage dependencies.

### Registration Process
During the registration process, the user is required to provide their name, email, phone number, and password. The following steps outline the registration process:

1. Firebase Initialization:
   - A new user is initialized in Firebase, which assigns a unique user ID to each individual.

2. Kommunicate Random User ID:
   - Kommunicate's random user ID generator is used to generate a unique chat ID.
   - The generated chat ID is stored as a variable called "chatId."

3. Firestore Storage:
   - User data including name, email, password, userID, and chatID is stored in Firestore for future retrieval.

4. Data Retrieval:
   - User data is fetched from Firestore to ensure consistency and accuracy.

5. Kommunicate User Initialization:
   - Using the retrieved data, including chatId, name, email, appID, and phone number, the Kommunicate user is initialized.

6. User Registration:
   - The initialized user is registered using the Kommunicate platform, enabling access to the user's previous conversation threads.

### Profile Page
Upon completing the registration process, the user is redirected to the profile page. The profile page offers the following options:

- Show Conversation Button:
  - Clicking this button triggers the "show conversation" method.
  - The user is redirected to the conversation list within Kommunicate.

- Log Out and Delete User Buttons:
  - These buttons allow the user to log out or delete their account.
  - Logging out invokes the Kommunicate function responsible for logging out, ensuring a smooth chat logout experience.

### Login Process
When a user logs in using a different account, the following steps occur:

1. User Data Copy:
   - User data from Firestore is copied and associated with the current user.

2. ChatID Retrieval:
   - The user's specific chatID is retrieved from Firestore.

3. User Registration:
   - Using the retrieved chatID, the user is registered again, ensuring access to their previous conversation threads.

### Code and Demo
The code for the assignment is stored in two locations for easy access:

- GitHub Repository: [Insert GitHub link]
- Google Drive: [Insert Google Drive link]

In addition to the code, a demo video showcasing the functionality of the app is included for reference.

## Conclusion
This documentation provides a comprehensive explanation of the approach taken to integrate communication in the sample app. The utilization of Firebase for authentication, Firestore for data storage, and SwiftUI for app development has enabled the creation of a seamless user experience.

For any further inquiries or clarifications, please refer to the provided code, demo video, or reach out for assistance.

