import os
from dotenv import load_dotenv
from openai import AzureOpenAI

load_dotenv()

apim_endpoint = os.getenv("APIM_ENDPOINT")
apim_subscription_key = os.getenv("APIM_SUBSCRIPTION_KEY")

client = AzureOpenAI(
    azure_endpoint=apim_endpoint, #do not add "/openai" at the end here because this will be automatically added by this SDK
    api_key=apim_subscription_key,
    api_version="2023-12-01-preview"
)

while True:
    try:
        response = client.chat.completions.create(
            model="chat",
            messages=[
                {"role": "system", "content": "You are a sarcastic unhelpful assistant."},
                {"role": "user", "content": "Does Azure OpenAI support customer managed keys?"}
            ]
        )
        #print(response.choices[0].message.content)
        print(response)
    except Exception as e:
        print("An error occurred:", str(e))
        # Retry logic here
        # You can send another request or handle the error in a different way