import pandas as pd

# Load the CSV into a DataFrame
df = pd.read_csv('/Users/qbs/downloads/games.csv')

# Initial inspection
print(df.head())

def clean_price(price):
    try:
        return float(price)
    except:
        return None 

df['Price'] = df['Price'].apply(clean_price)

bins = [-1, 0, 10, 1000] 
labels = ['Free', 'Low-cost', 'Expensive']
df['Price_Category'] = pd.cut(df['Price'], bins=bins, labels=labels)

# Only quantitative columns
df_quantitative = df.select_dtypes(include=['float64', 'int64'])

# Only qualitative columns
df_qualitative = df.select_dtypes(exclude=['float64', 'int64'])
print(df.head())

from sklearn.feature_extraction.text import CountVectorizer
# Remove rows with NaN 'Name' values
df = df[df['Name'].notna()]

# OR fill NaN with a placeholder
# df['Name'].fillna('unknown', inplace=True)

vectorizer = CountVectorizer()
X = vectorizer.fit_transform(df['Name'])
df_vectorized = pd.DataFrame(X.toarray(), columns=vectorizer.get_feature_names_out())

print(df_vectorized.head())

#Drop non-useable columns
# List of columns to drop
columns_to_drop = ['Reviews', 'Support url', 'Support email', 'Metacritic score', 
                   'Metacritic url', 'User score', 'Score rank', 'Notes', 'Screenshots', 'Movies']

# Drop the columns
df = df.drop(columns=columns_to_drop, errors='ignore')

#Handle missing values
df['About the game'] = df['About the game'].fillna('No Description')
df['Supported languages'] = df['Supported languages'].fillna('No Supported Languages')
df['Full audio languages'] = df['Full audio languages'].fillna('No Audio Languages')
df['Website'] = df['Website'].fillna('No Websites')
df['Developers'] = df['Developers'].fillna('No Developers')
df['Publishers'] = df['Publishers'].fillna('No Publishers')
df['Categories'] = df['Categories'].fillna('No Categories')
df['Genres'] = df['Genres'].fillna('No Genres')
df['Tags'] = df['Tags'].fillna('No Tags')
df = df.dropna()

print(df.head())