from django.test import LiveServerTestCase
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time
import MySQLdb

class AuthenticationTest(LiveServerTestCase):

    def testlogin(self):

        driver = webdriver.Chrome()

        users = ['user1', 'user2', 'user3', 'user4', 'user5']
        pswrds = ['user1', 'user2', 'user3', 'user4', 'user5']
        num = ['33', '99', '34', '53', '00']

        for user,pswr,n in users,pswrds,num:

            driver.get('http://127.0.0.1:8000/accounts/login')

            username = driver.find_element_by_name('username')
            pswrd = driver.find_element_by_name('password')
            submit = driver.find_element_by_class_id('loginsubmit')

            # pswrd = driver.find_element_by_class_name('password')

            username.send_keys(user)
            pswrd.send_keys(pswr)
            # submit.send_keys(Keys.RETURN)

            time.sleep(5)
            
            assert ('Enter the OTP sent to 07x-xxx-xx-'+n) in driver.page_source

        driver.quit()


    def testthrottle(self):

        pass



    def test2fa(self):

        pass



    
        