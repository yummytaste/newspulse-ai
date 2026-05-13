def generate_summary(article):

    title = article["title"]

    description = article["description"]

    summary = f"""
🔥 {title}

{description}

আরও বিস্তারিত জানতে NewsPulse দেখুন।
"""

    return summary.strip()