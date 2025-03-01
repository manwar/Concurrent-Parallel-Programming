#!/usr/bin/env python3

import asyncio
import aiohttp

async def fetch_data(url):
    async with aiohttp.ClientSession() as session:
        async with session.get(url) as response:
            data = await response.text()
            print(f"Received data from {url}")
            return data

async def main():
    urls = [
        "https://www.google.com",
        "https://www.apple.com",
    ]

    tasks = [fetch_data(url) for url in urls]
    results = await asyncio.gather(*tasks)
    print("All tasks done!")

if __name__ == "__main__":
    asyncio.run(main())
