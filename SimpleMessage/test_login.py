import unittest
import os
from random import randint
from appium import webdriver
from time import sleep
from selenium.webdriver.common.keys import Keys

class LoginTests(unittest.TestCase):

    def setUp(self):
        app = ('/Users/macbookpro/Library/Developer/Xcode/DerivedData/SimpleMessage-bbyuwxyuwditdubmllbpspbsamng/Build/Products/Debug-iphonesimulator/SimpleMessage.app')
        self.driver = webdriver.Remote(
            command_executor='http://127.0.0.1:4723/wd/hub',
            desired_capabilities={
                'app': app,
                'platformName': 'iOS',
                'platformVersion': '12.4',
                'deviceName': 'iPhone 6',
                'automationName': 'XCUITest',
            }
        )

    def tearDown(self):
        self.driver.quit()
    
#    def testLogin(self):
#        self.testEmailField()
#        self.testPasswordField()
#        self.driver.find_element_by_accessibility_id('loginButton').click()
#        sleep(1)
#        smiley = self.driver.find_element_by_accessibility_id('smileyImage')
#        self.assertTrue(smiley.get_attribute('wdVisible'))
#
#    def testEmailField(self):
#        emailTF = self.driver.find_element_by_accessibility_id('emailTextField')
#        emailTF.send_keys("validEmail")
#        emailTF.send_keys(Keys.RETURN)
#        sleep(1)
#        self.assertEqual(emailTF.get_attribute("value"), "validEmail")

    def testPasswordField(self):
        
        passwordTF = self.driver.find_element_by_accessibility_id('contactItem')
        
        print("Hello World")

        
        #passwordTF.send_keys("validPW")
        #passwordTF.send_keys(Keys.RETURN)
        sleep(1)
#self.assertNotEqual(passwordTF.get_attribute("value"), "validPW")



if __name__ == '__main__':
    suite = unittest.TestLoader().loadTestsFromTestCase(LoginTests)
    unittest.TextTestRunner(verbosity=2).run(suite)
