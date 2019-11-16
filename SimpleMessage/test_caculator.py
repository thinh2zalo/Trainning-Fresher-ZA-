import unittest
import os
from random import randint
from appium import webdriver
from time import sleep
from selenium.webdriver.common.keys import Keys

class LoginTests(unittest.TestCase):

    def setUp(self):
        app = ('/Users/macbookpro/Library/Developer/Xcode/DerivedData/Calculator-alstwincsvlfcyelxomarnfnwgye/Build/Products/Debug-iphonesimulator/Calculator.app')
        self.driver = webdriver.Remote(
            command_executor='http://127.0.0.1:4723/wd/hub',
            desired_capabilities={
                'app': app,
                'platformName': 'iOS',
                'platformVersion': '',
                'deviceName': 'iPhone ',
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


    def testNumber1(self):
        number1 = self.driver.find_element_by_accessibility_id('num1').click()
        resultView = self.driver.find_element_by_accessibility_id('resultView')
        self.assertEqual(resultView.get_attribute('value'), '1')
    
    def testNumber2(self):
        number2 = self.driver.find_element_by_accessibility_id('num2').click()
        resultView = self.driver.find_element_by_accessibility_id('resultView')
        self.assertEqual(resultView.get_attribute('value'), '2')
    
    def testPlus(self):
        plustBtn = self.driver.find_element_by_accessibility_id('plusbtn').click()
        resultView = self.driver.find_element_by_accessibility_id('resultView')
        self.assertEqual(resultView.get_attribute('value'),'+')
    
    def calc(self):
        plustBtn = self.driver.find_element_by_accessibility_id('numCalc').click()
        resultView = self.driver.find_element_by_accessibility_id('resultView')
        self.assertEqual(resultView.get_attribute('value'),'3.0')
    
    def testPlusCanCalc(self):
        self.testNumber1()
#        self.testNumber1()
        self.testPlus()
        self.testNumber2()
        self.calc()
        resultView = self.driver.find_element_by_accessibility_id('resultView')
        self.assertEqual(resultView.get_attribute('value'), '3.0')
#    def testPasswordField(self):
#
#        passwordTF = self.driver.find_element_by_accessibility_id('btn_flash').click()
#
#        print("Hello World")
#
##
##        passwordTF.send_keys("validPW")
##        passwordTF.send_keys(Keys.RETURN)
#        sleep(1)
#        self.assertNotEqual("", "44.0")




if __name__ == '__main__':
    suite = unittest.TestLoader().loadTestsFromTestCase(LoginTests)
    unittest.TextTestRunner(verbosity=2).run(suite)
