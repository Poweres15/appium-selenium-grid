## Prerequisites

Before you can start using Appium for iOS testing, make sure you have the following components installed and configured:

1. **Download Appium Server**  
   Install the latest version of Appium. You can do this via npm:

   ```bash
   npm install -g appium
   ```

2. **Install XCUITest Driver for Appium**  
   Install the XCUITest driver, which is essential for running tests on iOS:

   ```bash
   appium driver install xcuitest
   ```

3. **Download iOS Simulators**  
   Ensure you have the required iOS simulators installed. You can download these using Xcode:

   - Open Xcode.
   - Navigate to **Xcode > Preferences > Components**.
   - Select and install the simulators you need.

4. **Build WebDriverAgent for Simulators**  
   WebDriverAgent is necessary for interacting with iOS simulators. Follow these steps to build it:
   - Clone the WebDriverAgent repository:
     ```bash
     git clone https://github.com/appium/WebDriverAgent.git
     ```
   - Open the `WebDriverAgent.xcodeproj` file in Xcode.
   - Select the appropriate scheme for your simulator.
   - Build the project by clicking on **Product > Build** or pressing `Command + B`.

## Additional Notes

- Make sure you have **Xcode** installed on your machine, as it is required for building simulators and WebDriverAgent.
- Ensure that you have the necessary permissions and configurations in Xcode to run the simulators.

Once you have completed all the prerequisites, you are ready to start using Appium for iOS testing!

## Selenium Grid Startup

### Generate config file for Selenium Grid Set up

run the following command. This will read variable.json and dynamically ceate: 1.**Generate Appium Configs file** 2.**Generate Node Config File that Link Appium** 3.**Generate docker-compose file with dynamic services**

```bash
./genrate-config.sh
```

### Create Selenium Grid With Appium Node

To set up the Selenium Grid, run the following command. This will:

1. **Start Appium Servers**: Multiple Appium servers will be initiated.
2. **Create Selenium Nodes Linked to Appium Servers**: Selenium nodes will be set up to connect to the Appium servers.
3. **Create Selenium Hub**: A Selenium Hub will be created to manage the test requests.

Execute the following command to start everything in detached mode:

```bash
./setup.sh
```

### Run WDIO Test

Once the Selenium Grid and Appium servers are running, you can execute your WDIO tests. First, move up one directory level:

```bash
cd ..
```

Then, run your test scripts using the following command:

```bash
npx wdio config/wdio.ios.conf.ts
```

### Tear Down Selenium Grid

```bash
cd selenium-grid
./teardown.sh
```

## Additional Notes

- Ensure that Docker is installed and running on your machine before executing the setup script.
- Make sure you have all the necessary configurations in your `docker-compose.yml` file to set up the Appium servers and Selenium nodes correctly.

Once you have completed these steps, your Selenium Grid setup should be up and running, and you can start executing your tests!
