# J-Crew-Analytics-Exercises

## Take Home Analytics Exercises
### Caitlin Ruble

"This is an exercise to gauge your familiarity with coding and think through analysis implications. You'll find a prompt and two columns below: 'Coding' and 'Questions'. For the 'Coding' portion please submit the SQL query you would run to figure out the answer. The tables are spelled out in the subsequent tabs and are populated with both a definition of the table/columns and SAMPLE data. The 'Questions' portion asks you to think through the implications of a given result.
Feel free to submit in whatever format you're most comfortable with."


### **Prompt** : 
You work for J.Crew. J.Crew has just acquired Madewell and you're working with a team that is trying to understand the Madewell business and opportunities to cross-sell to loyalty members. 

### My approach: 
I've used pandas and pandasql to load the sample databases, augment them with a little more mock data and ensure my queries are working. I've written the MySQL/PostgreSQL versions of the queries as commented-out code cells within [this notebook](https://github.com/caitlinruble/J-Crew-Analytics-Excercises/blob/bfe4a6ddc772e3eca497799cf1c1c06d463fd92a/JCrew%20Analytics%20Exercises.ipynb), and I have also saved these to individual .sql files. **These should be considered my final answers**, though the SQLite queries in the notebook show my experimentation process and the results of running these queries with the provided sample data. Please note that SQLlite has some subtle syntax differences from MySQL.

**Answers to the Analysis Questions are located in [this PDF file](https://github.com/caitlinruble/J-Crew-Analytics-Excercises/blob/c81529030e39962b7fa16b302c4788d0cba6976d/J.%20Crew%20Take%20home%20responses.pdf) and also in the [notebook](https://github.com/caitlinruble/J-Crew-Analytics-Excercises/blob/bfe4a6ddc772e3eca497799cf1c1c06d463fd92a/JCrew%20Analytics%20Exercises.ipynb).** 

## Results

1. [Q1--Monthly Sales by Family Size](https://github.com/caitlinruble/J-Crew-Analytics-Excercises/blob/bfe4a6ddc772e3eca497799cf1c1c06d463fd92a/SQL%20Q1_Monthly%20Sales%20by%20Family%20Size.sql) 
<img width="1109" alt="Screen Shot 2022-10-31 at 12 24 18 PM" src="https://user-images.githubusercontent.com/96548036/199058406-8e39c7f1-d27e-41c8-9c3e-3e8d01fc62a1.png">

**Analysis Q**: 
Why would J.Crew care about this? If Madewell's sales is high and increasing for Single family types, how should Madewell think about that? What else would you want to know?
**My Answer:**
This is a basic function that would allow J.Crew/Madewell to track which types of customers are making purchases, when those purchases and being made, how many purchases each group is making, and the quantity of items bought and the amount of money spent by each group. This paints a picture of sales behavior which can be leveraged for all sorts of things: marketing campaigns, sales predictions, supply chain forecasting, etc.
If Madewell's sales are high and increasing for Single family types, it shows us that the current marketing, onboarding, product quality & selection and price point are all working for this family type right now. Madewell could lean into this by increasing their marketing toward Single people, aiming to cast a wider net and onboard more new customers in this group. It would be important for Madewell to consider which products are most popular with this group and ensure their supply chain is equipped to handle the greater demand that would be the goal of such a marketing campaign. This could be investigated by tweaking the SQL query to include the specifics of which type of items are being purchased by this group over time: their quantity, cost, net profit to the company, etc. We could analyze the sales trend data to uncover insights into product popularity and quantify the bottom line for J.Crew/Madewell. In this way, we could uncover the types and quantity of products the company needs to make to keep up with demand, use data to inform future product development and identify marketing and J.Crew/Madewell crossover opportunities in this customer base.
On the other hand, Madewell could consider the disparities between the Single family type and the other family types; perhaps there is market potential to capture more customers who fall into one of the other family types. I would start by comparing the monthly sales behavior of each group and identify the group(s) with the most similarity in purchasing behavior to the Single family type. Then, I'd investigate what the disparities are: do we simply have fewer customers of this group? Are they buying the same products or different products? Would it be reasonable for Madewell to increase production and marketing of the products this group is buying? 
![image](https://user-images.githubusercontent.com/96548036/199060513-ff7a74ef-2d9e-4079-a735-65e7e3f6c32c.png)



2. [Q2--Mean Cart Value by Year Cohort](https://github.com/caitlinruble/J-Crew-Analytics-Excercises/blob/bfe4a6ddc772e3eca497799cf1c1c06d463fd92a/SQL%20Q2_Mean%20cart%20value%20by%20year%20cohort.sql) 
<img width="1132" alt="Screen Shot 2022-10-31 at 12 20 57 PM" src="https://user-images.githubusercontent.com/96548036/199057664-ffd663ca-2fc6-4f82-9a33-e7254b0f2d4a.png">


3. [Q3--Difference in Value Between First and Second Cart Order by Customer](https://github.com/caitlinruble/J-Crew-Analytics-Excercises/blob/bfe4a6ddc772e3eca497799cf1c1c06d463fd92a/SQL%20Q3_Difference%20between%20first%20and%20second%20cart%20order%20by%20customer.sql) 
<img width="1031" alt="Screen Shot 2022-10-31 at 12 21 29 PM" src="https://user-images.githubusercontent.com/96548036/199057779-93fd3c85-2062-4243-9f52-84a4c820f64a.png">



