from django.test import LiveServerTestCase
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time

"""
class Authentication_Test(LiveServerTestCase):
    
    def test_authentication(self):

        driver = webdriver.Chrome()
        
        users = ['user1', 'user2', 'user3', 'user4']
        pswrds = ['user1', 'user2', 'user3', 'user4']
        num = ['33', '99', '34', '53']
        
        for user,pswr,n in zip(users,pswrds,num):
        
            driver.get('http://127.0.0.1:8000/accounts/login')

            username = driver.find_element_by_name('username')
            pswrd = driver.find_element_by_name('password')
            submit = driver.find_element_by_id('loginsubmit')

            username.send_keys(user)
            pswrd.send_keys(pswr)
            submit.send_keys(Keys.RETURN)

            assert ('Enter the OTP sent to 07x-xxx-xx-'+n) in driver.page_source

        driver.quit()


    def test_failed_authentication(self):

        driver = webdriver.Chrome()
        
        users = ['user1', 'user2', 'user3', 'user4']
        
        for user in users:
        
            driver.get('http://127.0.0.1:8000/accounts/login')

            username = driver.find_element_by_name('username')
            pswrd = driver.find_element_by_name('password')
            submit = driver.find_element_by_id('loginsubmit')

            username.send_keys(user)
            pswrd.send_keys('wrongpswrd')
            submit.send_keys(Keys.RETURN)

            assert ('Invalid Credentials') in driver.page_source

        driver.quit()


    def test_2fa(self):

        driver = webdriver.Chrome()

        users = ['user1', 'user2', 'user3', 'user4']
        pswrds = ['user1', 'user2', 'user3', 'user4']
        
        for user,pswr in zip(users,pswrds):

            driver.get('http://127.0.0.1:8000/accounts/login')

            username = driver.find_element_by_name('username')
            pswrd = driver.find_element_by_name('password')
            submit = driver.find_element_by_id('loginsubmit')

            username.send_keys(user)
            pswrd.send_keys(pswr)
            submit.send_keys(Keys.RETURN)

            otp = driver.find_element_by_name('otp')
            otpbtn = driver.find_element_by_id('otpsubmit')
            
            otp.send_keys('123456')
            otpbtn.send_keys(Keys.RETURN)

            assert ('Invalid OTP') in driver.page_source

        driver.quit()
    

    def test_resend_otp(self):

        driver = webdriver.Chrome()
        driver.get('http://127.0.0.1:8000/accounts/login')

        username = driver.find_element_by_name('username')
        pswrd = driver.find_element_by_name('password')
        submit = driver.find_element_by_id('loginsubmit')

        username.send_keys('user5')
        pswrd.send_keys('user5')
        submit.send_keys(Keys.RETURN)
        
        for i in range (3):

            resend = driver.find_element_by_link_text('Resend OTP')
            resend.click()
            assert ('Enter the OTP sent to 07x-xxx-xx-00') in driver.page_source

        resend = driver.find_element_by_link_text('Resend OTP')
        resend.click()
        assert ('Try again in') in driver.page_source

        driver.quit()
"""


class Throttling_Test(LiveServerTestCase):
    
    def test_throttle_login(self):

        driver = webdriver.Chrome()
        driver.get('http://127.0.0.1:8000/accounts/login')

        for i in range (5):

            username = driver.find_element_by_name('username')
            pswrd = driver.find_element_by_name('password')
            submit = driver.find_element_by_id('loginsubmit')

            username.send_keys('user1')
            pswrd.send_keys('wrongpswrd')
            submit.send_keys(Keys.RETURN)

            assert ('Invalid Credentials') in driver.page_source

        username = driver.find_element_by_name('username')
        pswrd = driver.find_element_by_name('password')
        submit = driver.find_element_by_id('loginsubmit')

        username.send_keys('user1')
        pswrd.send_keys('wrongpswrd')
        submit.send_keys(Keys.RETURN)

        assert ('Maximum Rate Exceeded.') in driver.page_source

        time.sleep(350)
        driver.quit()


    def test_throttle_otp(self):

        driver = webdriver.Chrome()
        driver.get('http://127.0.0.1:8000/accounts/login')

        username = driver.find_element_by_name('username')
        pswrd = driver.find_element_by_name('password')
        submit = driver.find_element_by_id('loginsubmit')

        username.send_keys('user1')
        pswrd.send_keys('user1')
        submit.send_keys(Keys.RETURN)

        for i in range (5):

            otp = driver.find_element_by_name('otp')
            otpbtn = driver.find_element_by_id('otpsubmit')
  
            otp.send_keys('123456')
            otpbtn.send_keys(Keys.RETURN)

            assert ('Invalid OTP') in driver.page_source

        otp = driver.find_element_by_name('otp')
        otpbtn = driver.find_element_by_id('otpsubmit')

        otp.send_keys('123456')
        otpbtn.send_keys(Keys.RETURN)

        assert ('Maximum Rate Exceeded.') in driver.page_source

        driver.quit()


"""
class Session_Authorization_Test(LiveServerTestCase):

    def test_session_allow(self):

        driver = webdriver.Chrome()
        driver.get('http://127.0.0.1:8000/accounts/login')

        username = driver.find_element_by_name('username')
        pswrd = driver.find_element_by_name('password')
        remember = driver.find_element_by_name('remember-me')
        submit = driver.find_element_by_id('loginsubmit')

        username.send_keys('user1')
        pswrd.send_keys('user1')
        remember.click()
        submit.send_keys(Keys.RETURN)

        assert ('Dashboard') in driver.page_source

        driver.get('http://127.0.0.1:8000/accounts/login')
        assert ('Login') in driver.page_source

    
    def test_session_deny(self):

        driver = webdriver.Chrome()
        driver.get('http://127.0.0.1:8000/accounts/login')

        assert ('Login') in driver.page_source
"""