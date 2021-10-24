from unittest.loader import findTestCases
from django.test import LiveServerTestCase
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time
from selenium.webdriver.support.select import Select
from webdriver_manager.chrome import ChromeDriverManager
import pickle

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

        time.sleep(10)
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



class end2end_Test(LiveServerTestCase):


    def setUp(self):
        self.driver = webdriver.Chrome(ChromeDriverManager().install())

    def tearDown(self):
        self.driver.quit()


    def test_a_login(self):
        
        self.driver.get('http://127.0.0.1:8000/accounts/login')

        """username = self.driver.find_element_by_name('username')
        pswrd = self.driver.find_element_by_name('password')
        submit = self.driver.find_element_by_id('loginsubmit')

        username.send_keys('user1')
        pswrd.send_keys('user1')
        submit.send_keys(Keys.RETURN)"""

        time.sleep(10)
        assert ('Dashboard') in self.driver.page_source


    def test_b_main4_places(self):

        self.driver.get('http://127.0.0.1:8000/accounts/login')
        time.sleep(10)
        assert ('Dashboard') in self.driver.page_source

        place1 = self.driver.find_element_by_id('one place')
        place2 = self.driver.find_element_by_id('two place')
        place3 = self.driver.find_element_by_id('three place')
        place4 = self.driver.find_element_by_id('four place')

        time.sleep(10)
        assert ('ODEL') in place1
        assert ("People's Bank") in place2
        assert ('Post Office') in place3
        assert ('Sathsara Shopping Center') in place4


    def test_c_main4_percentages(self):

        self.driver.get('http://127.0.0.1:8000/accounts/login')
        time.sleep(10)
        assert ('Dashboard') in self.driver.page_source

        perc1 = self.driver.find_element_by_id('one percent')
        perc2 = self.driver.find_element_by_id('two percent')
        perc3 = self.driver.find_element_by_id('three percent')
        perc4 = self.driver.find_element_by_id('four percent')

        time.sleep(10)
        assert ('35%') in perc1
        assert ('30%') in perc2
        assert ('26%') in perc3
        assert ('22%') in perc4


    def test_d_trace_names(self):

        self.driver.get('http://127.0.0.1:8000/accounts/login')
        time.sleep(10)
        assert ('Dashboard') in self.driver.page_source

        trace = self.driver.find_element_by_link_text('Trace my locations')
        trace.click()

        loc1 = self.driver.find_element_by_xpath("//table/tr[2]/td[3]")
        loc2 = self.driver.find_element_by_xpath("//table/tr[3]/td[3]")
        loc3 = self.driver.find_element_by_xpath("//table/tr[4]/td[3]")
        loc4 = self.driver.find_element_by_xpath("//table/tr[5]/td[3]")
        loc5 = self.driver.find_element_by_xpath("//table/tr[6]/td[3]")
        loc6 = self.driver.find_element_by_xpath("//table/tr[7]/td[3]")
        loc7 = self.driver.find_element_by_xpath("//table/tr[8]/td[3]")
        loc8 = self.driver.find_element_by_xpath("//table/tr[9]/td[3]")
        loc9 = self.driver.find_element_by_xpath("//table/tr[10]/td[3]")
        loc10 = self.driver.find_element_by_xpath("//table/tr[11]/td[3]")

        time.sleep(10)
        assert ('ODEL') in loc1
        assert ("People's Bank") in loc2
        assert ('Sampath Bank') in loc3
        assert ('ODEL') in loc4
        assert ('Post Office') in loc5
        assert ('University of Kelaniya') in loc6
        assert ("McDonald's Battaramulla") in loc7
        assert ('Pilimathalawa Tea Factory') in loc8
        assert ('Sathsara Shopping Center') in loc9
        assert ('Post Office') in loc10



    def test_e_trace_percentages(self):

        self.driver.get('http://127.0.0.1:8000/accounts/login')
        time.sleep(10)
        assert ('Dashboard') in self.driver.page_source

        trace = self.driver.find_element_by_link_text('Trace my locations')
        trace.click()

        per1 = self.driver.find_element_by_xpath("//table/tr[2]/td[5]")
        per2 = self.driver.find_element_by_xpath("//table/tr[3]/td[5]")
        per3 = self.driver.find_element_by_xpath("//table/tr[4]/td[5]")
        per4 = self.driver.find_element_by_xpath("//table/tr[5]/td[5]")
        per5 = self.driver.find_element_by_xpath("//table/tr[6]/td[5]")
        per6 = self.driver.find_element_by_xpath("//table/tr[7]/td[5]")
        per7 = self.driver.find_element_by_xpath("//table/tr[8]/td[5]")
        per8 = self.driver.find_element_by_xpath("//table/tr[9]/td[5]")
        per9 = self.driver.find_element_by_xpath("//table/tr[10]/td[5]")
        per10 = self.driver.find_element_by_xpath("//table/tr[11]/td[5]")

        time.sleep(10)
        assert ('35%') in per1
        assert ('30%') in per2
        assert ('5%') in per3
        assert ('5%') in per4
        assert ('10%') in per5
        assert ('15%') in per6
        assert ('19%') in per7
        assert ('19%') in per8
        assert ('22%') in per9
        assert ('26%') in per10


    def test_f_trace_temp(self):

        self.driver.get('http://127.0.0.1:8000/accounts/login')
        time.sleep(10)
        assert ('Dashboard') in self.driver.page_source

        trace = self.driver.find_element_by_link_text('Trace my locations')
        trace.click()

        temp1 = self.driver.find_element_by_xpath("//table/tr[2]/td[6]")
        temp2 = self.driver.find_element_by_xpath("//table/tr[3]/td[6]")
        temp3 = self.driver.find_element_by_xpath("//table/tr[4]/td[6]")
        temp4 = self.driver.find_element_by_xpath("//table/tr[5]/td[6]")
        temp5 = self.driver.find_element_by_xpath("//table/tr[6]/td[6]")
        temp6 = self.driver.find_element_by_xpath("//table/tr[7]/td[6]")
        temp7 = self.driver.find_element_by_xpath("//table/tr[8]/td[6]")
        temp8 = self.driver.find_element_by_xpath("//table/tr[9]/td[6]")
        temp9 = self.driver.find_element_by_xpath("//table/tr[10]/td[6]")
        temp10 = self.driver.find_element_by_xpath("//table/tr[11]/td[6]")

        time.sleep(10)
        assert ('35%') in temp1
        assert ('30%') in temp2
        assert ('5%') in temp3
        assert ('5%') in temp4
        assert ('10%') in temp5
        assert ('15%') in temp6
        assert ('19%') in temp7
        assert ('19%') in temp8
        assert ('22%') in temp9
        assert ('26%') in temp10


    def test_g_filter(self):

        self.driver.get('http://127.0.0.1:8000/accounts/login')
        time.sleep(10)
        assert ('Dashboard') in self.driver.page_source

        trace = self.driver.find_element_by_link_text('Trace my locations')
        trace.click()

        filter = self.driver.find_element_by_id('myInput')
        filter.send_keys('ODEL')

        l1 = self.driver.find_element_by_xpath("//table/tr[2]/td[4]")
        l2 = self.driver.find_element_by_xpath("//table/tr[3]/td[4]")

        time.sleep(10)
        assert ('ODEL, Makola Road, Kiribathgoda') in l1
        assert ('ODEL, Alexandra Place, Colombo') in l2


    def test_h_search_location(self):

        self.driver.get('http://127.0.0.1:8000/accounts/login')
        time.sleep(10)
        assert ('Dashboard') in self.driver.page_source

        search = self.driver.find_element_by_link_text('Check a location')
        search.click()

        drop1 = self.driver.find_element_by_name('merchant')
        drop2 = self.driver.find_element_by_name('area')

        drop1.select_by_visible_text('KCC')
        drop2.select_by_visible_text('Kandy')

        btn = self.driver.find_element_by_name('submit-1')
        btn.send_keys(Keys.RETURN)

        time.sleep(10)
        per = self.driver.find_element_by_id('percentage')
        time.sleep(10)
        assert ('12%') in per




