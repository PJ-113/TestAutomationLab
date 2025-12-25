*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${CHROME_BROWSER_PATH}    C:${/}ChromeForTesting${/}chrome-win64${/}chrome.exe
${CHROME_DRIVER_PATH}     C:${/}ChromeForTesting${/}chromedriver-win64${/}chromedriver.exe
${REGPAGE}    http://localhost:7272/Lab4/Registration.html
${BROWSER}     Firefox
${FNAME}    Somyod
${LNAME}    Sodsai
${OGZ}    CS KKU
${EMAIL}    somyod@kkumail.com
${PHONE}    091-001-1234

*** Keywords ***
Start Chrome
    ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    ${chrome_options.binary_location}    Set Variable    ${CHROME_BROWSER_PATH}
    ${service}    Evaluate    selenium.webdriver.chrome.service.Service(executable_path=r"${CHROME_DRIVER_PATH}")    modules=selenium.webdriver.chrome.service
    Create Webdriver    Chrome    options=${chrome_options}    service=${service}
    Go To    ${REGPAGE}

*** Test Cases ***
Open Workshop Registration Page
    Start Chrome
	Page Should Contain    Workshop Registration
	Close Browser

Register Success No Organization Info
	Start Chrome
    Input Text    firstname    ${FNAME}
	Input Text    lastname    ${LNAME}
	Input Text    organization    ${EMPTY}
	Input Text    email    ${EMAIL}
	Input Text    phone    ${PHONE}
	Click Button    registerButton
	Wait Until Page Contains    Thank you    5s
	Title Should Be    Success
	Page Should Contain    Thank you for registering with us.
	Page Should Contain    We will send a confirmation to your email soon.	
	Close Browser