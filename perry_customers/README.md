Welcome to your new dbt project!

I started by connecting my dbt project to snowflake and created the tables and the users which you can
find in the snowflake_setup.md file.
After creating the tables, I uploaded the csv's of the provided data into snowflake using the UI.
I edited the source file so that dbt could parse the table.
In the intermediate folder, I did some cleaning of each table and renamed columns. One of the tables had some duplicated rows. Then I created another table in which I joined all four tables together, in order to later create a single view in which I could show all the metrics given in a tableau dashboard with the requested cohorting capabilities.

In the final datamart folder, I wrote the SQL script which contains all the necessary computed columns with various window functions.

All metrics can be cohorted by the transaction date, the payment method, the customer state and the customer sign up date, as they are all separate columns in the table. They would likely be dimensions in tableau.

I summed the total price per customer to represent the total lifetime spend per customer. I assumed that this represents the lifetime spend. This column would be used to compute the average lifetime value per customer in Tableau.

I summed the total price per transaction. This column would be used to compute the average spend amount per transaction and the average dollar volume of transactions in Tableau.

The column of transactions can be counted in Tableau.

I counted the unique number of transactions per customer. This column would be used to compute the number of transactions per customer in Tableau.

The total dollar volume of transactions can be computed by summing the price of each transaction column.

I summed the quantity of products by product id and the product category. These columns would be used to compute the counts of each product sold.

I counted the unique customers to have purchased by product id and product category. These columns would be used to compute the number of unique customers for each product sold.

Finally, I created an indicator column which indicates whether or not a customer has spent more than $1000, thus far. 

I also wrote tests to ensure that all the computations were correct.


### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
