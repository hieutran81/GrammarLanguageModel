import os
import openai
import pandas
openai.api_key = ''
openai.Model.list()


INPUT = pandas.read_excel("input_GPT3_complexNP-island2.xlsx")
RESULTS = pandas.DataFrame(data=None, index=None, columns=['item','Correct','gap','island','C1','C2','Response'])


#Testing
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


for row in range(84):
  CONT = INPUT.loc[row,'continuation']
  C1 = INPUT.loc[row,'prefix']
  C2 = INPUT.loc[row+84,'prefix']
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
  if row <=20:
    df = pandas.DataFrame({'item': [row+1], 'Correct': [response.choices[0].text==(" \""+C1+"\"")], 'gap': ['no'], 'island': ['subj_noisland'], 'C1':[C1], 'C2':[C2], 'Response':[response.choices[0].text.lstrip("\n")]})
    RESULTS = pandas.concat([RESULTS,df])
  else:
    if row <=41:
      df = pandas.DataFrame({'item': [row-20], 'Correct': [response.choices[0].text==(" \""+C2+"\"")], 'gap': ['yes'], 'island': ['subj_noisland'], 'C1':[C1], 'C2':[C2], 'Response':[response.choices[0].text.lstrip("\n")]})
      RESULTS = pandas.concat([RESULTS,df])
    else:
      if row <=62:
        df = pandas.DataFrame({'item': [row-41], 'Correct': [response.choices[0].text==(" \""+C1+"\"")], 'gap': ['no'], 'island': ['that_subj_island'], 'C1':[C1], 'C2':[C2], 'Response':[response.choices[0].text.lstrip("\n")]})
        RESULTS = pandas.concat([RESULTS,df])
      else:
        if row<=83:
          df = pandas.DataFrame({'item': [row-62], 'Correct': ['NA'], 'gap': ['yes'], 'island': ['that_subj_island'], 'C1':[C1], 'C2':[C2], 'Response':[response.choices[0].text.lstrip("\n")]})
          RESULTS = pandas.concat([RESULTS,df])
print(RESULTS)
RESULTS.to_csv("complexNP_island_continuation2.csv")




for row in range(84):
  CONT = INPUT.loc[row,'continuation']
  C1 = INPUT.loc[row,'prefix']
  C2 = INPUT.loc[row+84,'prefix']
  RealQ = "\""+C1+" "+CONT+"\"\n\""+C1+" "+CONT+"\"\n"
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
  if row <=20:
    df = pandas.DataFrame({'item': [row+1], 'Correct': [response.choices[0].text==("\""+C1+"\"")], 'gap': ['no'], 'island': ['subj_noisland'], 'C1':[C1], 'C2':[C2], 'Response':[response.choices[0].text.lstrip("\n")]})
    RESULTS = pandas.concat([RESULTS,df])
  else:
    if row <=41:
      df = pandas.DataFrame({'item': [row-20], 'Correct': [response.choices[0].text==("\""+C2+"\"")], 'gap': ['yes'], 'island': ['subj_noisland'], 'C1':[C1], 'C2':[C2], 'Response':[response.choices[0].text.lstrip("\n")]})
      RESULTS = pandas.concat([RESULTS,df])
    else:
      if row <=62:
        df = pandas.DataFrame({'item': [row-41], 'Correct': [response.choices[0].text==("\""+C1+"\"")], 'gap': ['no'], 'island': ['that_subj_island'], 'C1':[C1], 'C2':[C2], 'Response':[response.choices[0].text.lstrip("\n")]})
        RESULTS = pandas.concat([RESULTS,df])
      else:
        if row<=83:
          df = pandas.DataFrame({'item': [row-62], 'Correct': [response.choices[0].text=="Neither sequence is a complete sentence."], 'gap': ['yes'], 'island': ['that_subj_island'], 'C1':[C1], 'C2':[C2], 'Response':[response.choices[0].text.lstrip("\n")]})
          RESULTS = pandas.concat([RESULTS,df])
print(RESULTS)
RESULTS.to_csv("complexNP_island_completeness2.csv")
