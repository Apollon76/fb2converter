import urllib.request
import sys
import string
from bs4 import BeautifulSoup
from transliterate import translit


def main():
    address = sys.argv[1]
    soup = BeautifulSoup(urllib.request.urlopen(address), 'lxml')
    title = translit(soup.title.string, "ru", reversed=True)
    valid_chars = '-_.()' + string.ascii_letters + string.digits
    title = ''.join(map(lambda c: c if c in valid_chars else ' ', title))
    print(title, end='')

main()
