8CRES
An IOS app that lets you keep track and transfer money to save for downpayment of a home.
1. Go to the Plaid website to get API keys for their Development and Sandbox environment.
2. If you want to not use real financial institution you will need to open /Knot/API/PlaidManager.swift and change the environment variable to .sandbox from the class' init(). Then, you can select any financial institution and use the username: user_good and password: pass_good to successfully link a dummy account.
3. This app uses CocoaPods-keys to store the API keys. Open a terminal in the application's folder and run "pod install". You will be prompted to enter in the API keys.
4. Open 8cres.xcworkspace in Xcode.
5. Build and run the app.


