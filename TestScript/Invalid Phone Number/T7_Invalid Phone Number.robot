*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${CHROME_BROWSER_PATH}    C:${/}ChromeForTesting${/}chrome-win64${/}chrome.exe
${CHROME_DRIVER_PATH}     C:${/}ChromeForTesting${/}chromedriver-win64${/}chromedriver.exe
${REGPAGE}    http://localhost:7272/Lab4/Registration.html
${FNAME}    Somyod
${LNAME}    Sodsai
${OGZ}    CS KKU
${EMAIL}    somyod@kkumail.com
${PHONE}    091-001-1234
${IVPHONE}    osfsfplsa

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

Invalid Phone Number
	Start Chrome
    Input Text    firstname    ${FNAME}
	Input Text    lastname    ${LNAME}
	Input Text    organization    ${OGZ}
	Input Text    email    ${EMAIL}
	Input Text    phone    ${IVPHONE}
	Click Button    registerButton
	Location Should Be    ${REGPAGE}
	Page Should Contain   Please enter a valid phone number, e.g., 081-234-5678, 081 234 5678, or 081.234.5678	
	Close Browser