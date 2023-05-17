import os
import openai
import pandas
openai.api_key = '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'
openai.Model.list()


INPUT = pandas.read_excel("input_GPT3_wh-island.xlsx")
RESULTS = pandas.DataFrame(data=None, index=None, columns=['item','Correct','gap','island','C1','C2','Response'])
"""
response = openai.Completion.create(
  model="text-davinci-003",
  prompt="Q: Which sentence is grammatical?\n\"The teacher woke up the flower.\"\n\"I will tell you who he went\"\nAns: \"The teacher woke up the flower.\"\nQ: Which sentence is grammatical?\n\"The teacher ate the umbrella.\"\n\"The student read the books.\"\nAns: Both are grammatical.\nQ: Which sentence is grammatical?\n\"I am a men.\"\n\"I am a man.\"\nAns: \"I am a man.\"\nQ: Which sentence is grammatical?\n\"I love girl.\"\n\"I will loving a girl.\"\nAns: Neither is grammatical.\nQ: Which sentence is grammatical?\n\"I know what you mean.\"\n\"I know that you mean.\"\nAns: \"I know what you mean.\"\nQ: Which sentence is grammatical?\n\"I like sing.\"\n\"I enjoy sing.\"\nAns: Neither is grammatical.\nQ: Which sentence is grammatical?\n\"This box is made of.\"\n\"We should let them living in your.\"\nAns: Neither is grammatical.\nQ: Which sentence is grammatical?\n\"The woman who saw you yesterday is my mom.\"\n\"The picture you see was drawn by the wealthy man.\"\nAns: Both are grammatical.\nQ: Which sentence is grammatical?\n\"She likes he.\"\n\"Them like her.\"\nAns: ",
  temperature=0,
  max_tokens=3600,
  top_p=0,
  frequency_penalty=0,
  presence_penalty=0
)
print(response.choices[0].text)
"""

response = openai.Completion.create(
  model="text-davinci-003",
  prompt="Q: Which sequence is more likely to be continued with \"and she likes to eat pie\"?\n\"He likes to eat ice cream\"\n\"Does he like to eat ice cream\"\nAns:\"Does he like to eat ice cream\"\n\nQ: Which sequence is more likely to be continued with \"tall and old\"?\n\"This bug is really\"\n\"This tree is really\"\nAns:\"This tree is really\"\n\n\nQ: Which sequence is more likely to be continued with \"hearing your speech.\"?\n\"I am excited to\"\n\"I look forward to\"\nAns:",
  temperature=0,
  max_tokens=3600,
  top_p=0,
  frequency_penalty=0,
  presence_penalty=0
)
print(response.choices[0].text)


"""
for row in range(96):
  CONT = INPUT.loc[row,'continuation']
  C1 = INPUT.loc[row,'prefix']
  C2 = INPUT.loc[row+96,'prefix']
  RealQ = "\""+C1+"\"\n\""+C2+"\"\n"
  prompt="Q: Which sequence is more likely to be continued with \"and she likes to eat pie\"?\n\"He likes to eat ice cream\"\n\"Does he like to eat ice cream\"\nAns:\"Does he like to eat ice cream\"\n\nQ: Which sequence is more likely to be continued with \"tall and old\"?\n\"This bug is really\"\n\"This tree is really\"\nAns:\"This tree is really\"\n\n\nQ: Which sequence is more likely to be continued with \""+CONT+"\"\n"+RealQ+"Ans:"
  response = openai.Completion.create(
    model="text-davinci-003",
    prompt="Q: Which sequence is more likely to be continued with \"and she likes to eat pie\"?\n\"He likes to eat ice cream\"\n\"Does he like to eat ice cream\"\nAns:\"Does he like to eat ice cream\"\n\nQ: Which sequence is more likely to be continued with \"tall and old\"?\n\"This bug is really\"\n\"This tree is really\"\nAns:\"This tree is really\"\n\n\nQ: Which sequence is more likely to be continued with \""+CONT+"\"\n"+RealQ+"Ans:",
    temperature=0,
    max_tokens=3600,
    top_p=0,
    frequency_penalty=0,
    presence_penalty=0
  )
  print(prompt)
  print(response.choices[0].text)
  if row <=23:
    df = pandas.DataFrame({'item': [row+1], 'Correct': [response.choices[0].text==(" \""+C2+"\"")], 'gap': ['no'], 'island': ['that'], 'C1':[C1], 'C2':[C2], 'Response':[response.choices[0].text.lstrip("\n")]})
    RESULTS = pandas.concat([RESULTS,df])
  else:
    if row <=47:
      df = pandas.DataFrame({'item': [row-23], 'Correct': [response.choices[0].text==(" \""+C1+"\"")], 'gap': ['yes'], 'island': ['that'], 'C1':[C1], 'C2':[C2], 'Response':[response.choices[0].text.lstrip("\n")]})
      RESULTS = pandas.concat([RESULTS,df])
    else:
      if row <=71:
        df = pandas.DataFrame({'item': [row-47], 'Correct': [response.choices[0].text==(" \""+C2+"\"")], 'gap': ['no'], 'island': ['whether'], 'C1':[C1], 'C2':[C2], 'Response':[response.choices[0].text.lstrip("\n")]})
        RESULTS = pandas.concat([RESULTS,df])
      else:
        df = pandas.DataFrame({'item': [row-71], 'Correct': ['NA'], 'gap': ['yes'], 'island': ['whether'], 'C1':[C1], 'C2':[C2], 'Response':[response.choices[0].text.lstrip("\n")]})
        RESULTS = pandas.concat([RESULTS,df])
print(RESULTS)
RESULTS.to_csv("whether_island_continuation.csv")
"""
"""

RESULTS = pandas.DataFrame(data=None, index=None, columns=['item','Correct','gap','island','C1','C2','Response'])
for row in range(96):
  CONT = INPUT.loc[row,'continuation']
  C1 = INPUT.loc[row,'prefix']
  C2 = INPUT.loc[row+96,'prefix']
  RealQ = "\""+C1+".\"\n\""+C2+".\"\n"
  prompt="Q: Which sentence is grammatical?\n\"The teacher woke up the flower.\"\n\"I will tell you who he went\"\nAns: \"The teacher woke up the flower.\"\nQ: Which sentence is grammatical?\n\"The teacher ate the umbrella.\"\n\"The student read the books.\"\nAns: Both are grammatical.\nQ: Which sentence is grammatical?\n\"I am a men.\"\n\"I am a man.\"\nAns: \"I am a man.\"\nQ: Which sentence is grammatical?\n\"I love girl.\"\n\"I will loving a girl.\"\nAns: Neither is grammatical.\nQ: Which sentence is grammatical?\n\"I know what you mean.\"\n\"I know that you mean.\"\nAns: \"I know what you mean.\"\nQ: Which sentence is grammatical?\n\"I like sing.\"\n\"I enjoy sing.\"\nAns: Neither is grammatical.\nQ: Which sentence is grammatical?\n\"This box is made of.\"\n\"We should let them living in your.\"\nAns: Neither is grammatical.\nQ: Which sentence is grammatical?\n\"The woman who saw you yesterday is my mom.\"\n\"The picture you see was drawn by the wealthy man.\"\nAns: Both are grammatical.\nQ: Which sentence is grammatical?\n"+RealQ+"Ans: "
  response = openai.Completion.create(
    model="text-davinci-003",
    prompt="Q: Which sentence is grammatical?\n\"The teacher woke up the flower.\"\n\"I will tell you who he went\"\nAns: \"The teacher woke up the flower.\"\nQ: Which sentence is grammatical?\n\"The teacher ate the umbrella.\"\n\"The student read the books.\"\nAns: Both are grammatical.\nQ: Which sentence is grammatical?\n\"I am a men.\"\n\"I am a man.\"\nAns: \"I am a man.\"\nQ: Which sentence is grammatical?\n\"I love girl.\"\n\"I will loving a girl.\"\nAns: Neither is grammatical.\nQ: Which sentence is grammatical?\n\"I know what you mean.\"\n\"I know that you mean.\"\nAns: \"I know what you mean.\"\nQ: Which sentence is grammatical?\n\"I like sing.\"\n\"I enjoy sing.\"\nAns: Neither is grammatical.\nQ: Which sentence is grammatical?\n\"This box is made of.\"\n\"We should let them living in your.\"\nAns: Neither is grammatical.\nQ: Which sentence is grammatical?\n\"The woman who saw you yesterday is my mom.\"\n\"The picture you see was drawn by the wealthy man.\"\nAns: Both are grammatical.\nQ: Which sentence is grammatical?\n"+RealQ+"Ans: ",
    temperature=0,
    max_tokens=3600,
    top_p=0,
    frequency_penalty=0,
    presence_penalty=0
  )
  print(prompt)
  print(response.choices[0].text)
  if row <=23:
    df = pandas.DataFrame({'item': [row+1], 'Correct': [response.choices[0].text==("\""+C2+".\"")], 'gap': ['no'], 'island': ['that'], 'C1':[C1], 'C2':[C2], 'Response':[response.choices[0].text.lstrip("\n")]})
    RESULTS = pandas.concat([RESULTS,df])
  else:
    if row <=47:
      df = pandas.DataFrame({'item': [row-23], 'Correct': [response.choices[0].text==("\""+C1+".\"")], 'gap': ['yes'], 'island': ['that'], 'C1':[C1], 'C2':[C2], 'Response':[response.choices[0].text.lstrip("\n")]})
      RESULTS = pandas.concat([RESULTS,df])
    else:
      if row <=71:
        df = pandas.DataFrame({'item': [row-47], 'Correct': [response.choices[0].text==("\""+C2+".\"")], 'gap': ['no'], 'island': ['whether'], 'C1':[C1], 'C2':[C2], 'Response':[response.choices[0].text.lstrip("\n")]})
        RESULTS = pandas.concat([RESULTS,df])
      else:
        df = pandas.DataFrame({'item': [row-71], 'Correct': [response.choices[0].text=="Neither is grammatical."], 'gap': ['yes'], 'island': ['whether'], 'C1':[C1], 'C2':[C2], 'Response':[response.choices[0].text.lstrip("\n")]})
        RESULTS = pandas.concat([RESULTS,df])
print(RESULTS)
RESULTS.to_csv("whether_island_grammaticality.csv")

"""

RESULTS = pandas.DataFrame(data=None, index=None, columns=['item','Correct','gap','island','C1','C2','Response'])
for row in range(96):
  CONT = INPUT.loc[row,'continuation']
  C1 = INPUT.loc[row,'prefix']
  C2 = INPUT.loc[row+96,'prefix']
  RealQ = "\""+C1+".\"\n\""+C2+".\"\n"
  prompt="Q: Which sequence is a complete sentence?\n\"The teacher woke up the.\"\n\"I will tell you who he went.\"\nAns: Neither sequence is a complete sentence.\nQ: Which sequence is a complete sentence?\n\"The teacher ate the umbrella.\"\n\"The student read the books.\"\nAns: Both sequences are complete sentences.\nQ: Which sequence is a complete sentence?\n\"I am a man.\"\n\"I am a man who.\"\nAns: \"I am a man.\"\nQ: Which sequence is a complete sentence?\n\"I love short.\"\n\"I will loving a girl.\"\nAns: Neither sequence is a complete sentence.\nQ: Which sequence is a complete sentence?\n\"I know what you mean.\"\n\"I know that you mean.\"\nAns: \"I know what you mean.\"\nQ: Which sequence is a complete sentence?\n\"I like sing.\"\n\"I enjoy singing.\"\nAns: \"I enjoy singing.\"\nQ: Which sequence is a complete sentence?\n\"This box is made of.\"\n\"We should let them live in your.\"\nAns: Neither sequence is a complete sentence.\nQ: Which sequence is a complete sentence?\n\"The woman who saw you yesterday is my mom.\"\n\"The picture you see was drawn by the wealthy man.\"\nAns: Both sequences are complete sentences.\nQ: Which sequence is a complete sentence?\n"+RealQ+"Ans: "
  response = openai.Completion.create(
    model="text-davinci-003",
    prompt="Q: Which sequence is a complete sentence?\n\"The teacher woke up the.\"\n\"I will tell you who he went.\"\nAns: Neither sequence is a complete sentence.\nQ: Which sequence is a complete sentence?\n\"The teacher ate the umbrella.\"\n\"The student read the books.\"\nAns: Both sequences are complete sentences.\nQ: Which sequence is a complete sentence?\n\"I am a man.\"\n\"I am a man who.\"\nAns: \"I am a man.\"\nQ: Which sequence is a complete sentence?\n\"I love short.\"\n\"I will loving a girl.\"\nAns: Neither sequence is a complete sentence.\nQ: Which sequence is a complete sentence?\n\"I know what you mean.\"\n\"I know that you mean.\"\nAns: \"I know what you mean.\"\nQ: Which sequence is a complete sentence?\n\"I like sing.\"\n\"I enjoy singing.\"\nAns: \"I enjoy singing.\"\nQ: Which sequence is a complete sentence?\n\"This box is made of.\"\n\"We should let them live in your.\"\nAns: Neither sequence is a complete sentence.\nQ: Which sequence is a complete sentence?\n\"The woman who saw you yesterday is my mom.\"\n\"The picture you see was drawn by the wealthy man.\"\nAns: Both sequences are complete sentences.\nQ: Which sequence is a complete sentence?\n"+RealQ+"Ans: ",
    temperature=0,
    max_tokens=3600,
    top_p=0,
    frequency_penalty=0,
    presence_penalty=0
  )
  print(prompt)
  print(response.choices[0].text)
  if row <=23:
    df = pandas.DataFrame({'item': [row+1], 'Correct': [response.choices[0].text==("\""+C2+".\"")], 'gap': ['no'], 'island': ['that'], 'C1':[C1], 'C2':[C2], 'Response':[response.choices[0].text.lstrip("\n")]})
    RESULTS = pandas.concat([RESULTS,df])
  else:
    if row <=47:
      df = pandas.DataFrame({'item': [row-23], 'Correct': [response.choices[0].text==("\""+C1+".\"")], 'gap': ['yes'], 'island': ['that'], 'C1':[C1], 'C2':[C2], 'Response':[response.choices[0].text.lstrip("\n")]})
      RESULTS = pandas.concat([RESULTS,df])
    else:
      if row <=71:
        df = pandas.DataFrame({'item': [row-47], 'Correct': [response.choices[0].text==("\""+C2+".\"")], 'gap': ['no'], 'island': ['whether'], 'C1':[C1], 'C2':[C2], 'Response':[response.choices[0].text.lstrip("\n")]})
        RESULTS = pandas.concat([RESULTS,df])
      else:
        df = pandas.DataFrame({'item': [row-71], 'Correct': [response.choices[0].text=="Neither is grammatical."], 'gap': ['yes'], 'island': ['whether'], 'C1':[C1], 'C2':[C2], 'Response':[response.choices[0].text.lstrip("\n")]})
        RESULTS = pandas.concat([RESULTS,df])
print(RESULTS)
RESULTS.to_csv("whether_island_completeness.csv")


"""
for row in range(48):
 #CONT = INPUT.loc[row,'continuation']
  C1 = INPUT.loc[row,'prefix']
  C2 = INPUT.loc[row+96,'prefix']
  RealQ = "\""+C1+"\"\n\""+C2+"\"\n"
  prompt="Q: Which sequence is more likely to be continued with a colon?\n\"Here is what you need\"\n\"Do you need my help\"\nAns:\"Here is what you need\"\n\nQ: Which sequence is more likely to be continued with \"tall and old\"?\n\"This bug is really\"\n\"This tree is really\"\nAns:\"This tree is really\"\n\n\nQ: Which sequence is more likely to be continued with a period\n"+RealQ+"Ans:"
  response = openai.Completion.create(
    model="text-davinci-003",
    prompt="Q: Which sequence is more likely to be continued with a colon?\n\"Here is what you need\"\n\"Do you need my help\"\nAns:\"Here is what you need\"\n\nQ: Which sequence is more likely to be continued with \"tall and old\"?\n\"This bug is really\"\n\"This tree is really\"\nAns:\"This tree is really\"\n\n\nQ: Which sequence is more likely to be continued with a period\n"+RealQ+"Ans:",
    temperature=0,
    max_tokens=3600,
    top_p=0,
    frequency_penalty=0,
    presence_penalty=0
  )
  print(prompt)
  print(response.choices[0].text==(" \""+C2+".\""))
  print(response.choices[0].text)


"""