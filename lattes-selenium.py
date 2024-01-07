
# ---------------------------------

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
import os
import datetime

driver = webdriver.Firefox() 
driver.get('http://buscatextual.cnpq.br/buscatextual/busca.do')

# baixou até 
# 96 Gilberto Tadeu Lima



# ---------------------------------
# Change User Agent in Firefox Selenium

import random
from selenium import webdriver
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.firefox.firefox_profile import FirefoxProfile

# List of User-Agent strings
user_agents = [
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36",
    # Add more User-Agent strings as needed
]

# Set up Firefox profile
profile = FirefoxProfile()

# Choose a random User-Agent from the list
random_user_agent = random.choice(user_agents)
profile.set_preference("general.useragent.override", random_user_agent)

# Set up Firefox options
firefox_options = Options()
firefox_options.profile = profile

# Create a new instance of Firefox WebDriver with the desired options
driver = webdriver.Firefox(options=firefox_options)

# Your scraping logic goes here
# ...

# Close the driver
driver.quit()
