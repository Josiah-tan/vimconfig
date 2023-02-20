from tabulate import tabulate
import pandas as pd
import requests
from bs4 import BeautifulSoup

URL = "https://www.magnumsteno.com"
page = requests.get(URL)

soup = BeautifulSoup(page.content, "html.parser")
qa, lit = list(map(lambda x: dict(x),
                   list(map(lambda x: [
                       reversed(i.rsplit(' ', 1)) for i in x],
                            list(map(lambda x: x.split("; "),
                                     list(filter(
                                         lambda x: "Q&A" in x, (
                                             s.get_text() for s in soup.find_all("p")
                                             )))[0].split("Q&A: ")[1][:-1].split(".\nLit: ")))))))

print(tabulate(list(dict(**qa, **lit).items()), headers=["strokes", "translations"], tablefmt='orgtbl'))
