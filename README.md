## Creating a Subgraph

- https://docs.alchemy.com/docs/how-to-build-and-deploy-a-subgraph-using-alchemy-subgraphs

- https://thegraph.com/docs/en/developing/creating-a-subgraph/#writing-mappings

## SVG

1. base64 encode the raw svg html

```bash
$ base64 -i img/happy.svg
PHN2ZyB3aWR0aD0iMTAwIiBoZWlnaHQ9IjEwMCI+CiAgPGNpcmNsZSBjeD0iNTAiIGN5PSI1MCIg
cj0iNDAiIHN0cm9rZT0iZ3JlZW4iIHN0cm9rZS13aWR0aD0iNCIgZmlsbD0ieWVsbG93IiAvPgog
IDx0ZXh0IHg9IjQzIiB5PSI1NSIgZm9udC1mYW1pbHk9IlZlcmRhbmEiIGZvbnQtc2l6ZT0iMTUi
IGZpbGw9InJlZCI+MzM8L3RleHQ+Cjwvc3ZnPg==
```

2. add `data:image/svg+xml;base64,` before the base64 encoded svg

```
data:image/svg+xml;base64,
PHN2ZyB3aWR0aD0iMTAwIiBoZWlnaHQ9IjEwMCI+CiAgPGNpcmNsZSBjeD0iNTAiIGN5PSI1MCIg
cj0iNDAiIHN0cm9rZT0iZ3JlZW4iIHN0cm9rZS13aWR0aD0iNCIgZmlsbD0ieWVsbG93IiAvPgog
IDx0ZXh0IHg9IjQzIiB5PSI1NSIgZm9udC1mYW1pbHk9IlZlcmRhbmEiIGZvbnQtc2l6ZT0iMTUi
IGZpbGw9InJlZCI+MzM8L3RleHQ+Cjwvc3ZnPg==

```
