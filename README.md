# Startup Financial Analyzer

## Project Overview

The Startup Financial Analyzer is a Flutter-based mobile application developed as part of the CIS017-3 Undergraduate Project.

The application is designed to help startup users enter and review their financial information and understand their current financial position through a range of calculated financial indicators.

The application also provides additional features for supporting financial decision-making, including scenario analysis, revenue forecasting, financial reports, trend visualisation and an AI-generated financial insight.

## Main Features

The application includes the following features:

- User registration and login
- Financial data input
- Financial analysis and key performance indicators
- Profit and loss calculation
- Expense ratio calculation
- Revenue growth calculation
- Burn rate and cash runway analysis
- Financial health score
- Risk level and startup status
- Scenario analysis for hypothetical financial changes
- Revenue forecasting
- Historical financial reports
- Revenue and expense trend charts
- Gemini AI financial insight
- User profile and logout

## Technologies Used

The main technologies and services used in the project are:

- Flutter – mobile application development
- Dart – programming language
- Firebase Authentication – user authentication
- Cloud Firestore – storing user financial information
- Gemini API – generating AI-based financial insights
- fl_chart – displaying financial trend charts
- flutter_dotenv – handling environment variables

## Project Structure

The main folders in the project are organised as follows:

startup_financial_analyzer/
│
├── android/              Android project files
├── ios/                  iOS project files
├── lib/                  Main Flutter application source code
├── linux/                Linux platform files
├── macos/                macOS platform files
├── test/                 Test files
├── testing_evidence/     Project testing evidence
├── web/                  Web platform files
├── windows/              Windows platform files
│
├── pubspec.yaml          Project dependencies and configuration
├── pubspec.lock          Locked dependency versions
├── analysis_options.yaml Dart analysis configuration
├── .gitignore            Git ignore configuration
└── README.md             Project information and instructions

The main application code is located inside the lib folder. This contains the screens, widgets, models and services used by the application.

## Requirements

To run the project from the source code, the following are required:

- Flutter SDK
- Dart SDK
- Android Studio or another suitable Flutter development environment
- Android emulator or compatible Android device
- Internet connection
- Firebase configuration
- Gemini API configuration for the AI insight feature

The application was developed and tested using an Android emulator.

## Setting Up the Project

### 1. Open the Project

Open the startup_financial_analyzer folder in Android Studio, Visual Studio Code, or another suitable Flutter development environment.

### 2. Install Dependencies

Open a terminal in the project folder and run:

flutter pub get

This downloads the packages required by the application.

### 3. Configure Firebase

The application uses Firebase for authentication and storing financial data.

The required Firebase configuration should be available in the project before running the application.

### 4. Configure the Gemini API

The AI financial insight feature uses the Gemini API.

The API key is loaded through an environment variable rather than being written directly into the application source code.

The required environment variable is:

GEMINI_API_KEY=your_api_key_here

The actual API key should not be shared publicly or committed to a public Git repository.

For the submitted project, the Gemini API configuration should follow the instructions provided by the project supervisor or university.

## Running the Application

After completing the required configuration:

1. Start an Android emulator or connect a compatible Android device.
2. Open a terminal in the project directory.
3. Run:

flutter pub get

4. Run the application using:

flutter run

The application should then launch on the connected device or emulator.

## Using the Application

After launching the application, a user can create an account or log in using an existing account.

Once logged in, the main navigation provides access to the application's financial features.

The general workflow is:

Login / Registration
        ↓
Financial Input
        ↓
Financial Analysis
        ↓
Dashboard
        ↓
Scenario Analysis / Forecast / Reports / AI Insight

### Financial Analysis

The user enters the required financial information and submits it for analysis. The application calculates the relevant financial indicators and displays the results through the dashboard.

### Scenario Analysis

The scenario analysis feature allows users to explore hypothetical changes to selected financial values without directly changing their main financial records.

### Revenue Forecast

The forecast feature provides an estimated next-month revenue value based on the growth model implemented in the application.

### Reports and Trends

The reports section allows users to review previous financial analysis results. The trend chart provides a visual comparison of revenue and expenses across recorded analyses.

### Gemini AI Insight

The Gemini feature uses the calculated financial information to generate a concise financial assessment, including financial health, key risks, recommendations and an overall assessment.

An active internet connection and valid Gemini API configuration are required for this feature.

## Testing

Testing evidence produced during the development of the project is provided in the testing_evidence folder.

The application was tested through functional testing of the main features, including user authentication, financial input, calculations, scenario analysis, forecasting, reports, trend visualisation and AI insight generation.

## Important Notes

- An internet connection is required for Firebase services and the Gemini AI feature.
- Firebase configuration must be available for authentication and cloud data storage.
- The Gemini API key should be kept private and should not be shared publicly.
- The financial forecast and AI-generated insight are intended as supporting features and should not be treated as professional financial advice.
- The application should be tested using valid financial input values.

## Project Documentation

Additional project documentation is provided separately with the submission, including:

- Final Thesis Report
- User Manual
- Project Poster
- Testing Evidence
- Assignment 2 Top Sheet