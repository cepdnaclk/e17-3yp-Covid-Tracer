from django.test import LiveServerTestCase
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time

class AuthenticationTest(LiveServerTestCase):


    def testverification(self):

        pass



    def testthrottle(self):

        pass



    def test2fa(self):

        pass



    def testlogin(self):

        driver = webdriver.Chrome()
        driver.get('http://127.0.0.1:8000/')

        username = driver.find_element_by_name('username')
        pswrd = driver.find_element_by_class_name('password')
        submit = driver.find_element_by_class_id('loginsubmit')

        username.send_keys('user1')
        pswrd.send_keys('user1')
        submit.send_keys(keys.RETURN)

        time.sleep(5)

        assert 'user1' in driver.page_source

        driver.quit()
        