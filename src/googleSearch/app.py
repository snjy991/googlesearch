try:
    from googlesearch import search
except ImportError:
    print("No domain call amazon found")

# to search hostname
def lambda_handler(event, context):
    print("Lambda function is started...")
    query = "amazon"
    for j in search(query, tld="co.in", num=10, stop=1, pause=2):
        print(j)
        return j
