import feedparser

RSS_URL = "https://feeds.bbci.co.uk/news/world/rss.xml"


def fetch_news():

    feed = feedparser.parse(RSS_URL)

    articles = []

    for entry in feed.entries[:5]:

        article = {
            "title": entry.title,
            "description": entry.summary,
            "link": entry.link,
        }

        articles.append(article)

    return articles