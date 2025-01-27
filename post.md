Chain Golf Store
My Database Description: The goal of this project is to create a database for a chain golf store. That includes equipment and stock for each store location to see what is available at each.


Query I thought it did well on
Question: "Which equipment brand is the most stocked across all stores?"

GPT SQL Response:

SELECT e.brand, SUM(st.quantity) AS total_quantity
FROM Equipment e
JOIN Stock st ON e.equipment_id = st.equipment_id
GROUP BY e.brand
ORDER BY total_quantity DESC
LIMIT 1;

Friendly Response: "Titleist is the top-stocked brand across all stores, with 90 items."

Question that it tripped up on

Question: "Which city has the highest number of stores?"

GPT SQL Response:

SELECT c.city, COUNT(s.store_id) AS number_of_stores
FROM Store s
JOIN Contact c ON s.contact_id = c.contact_id
GROUP BY c.city
ORDER BY number_of_stores DESC
LIMIT 1;

Friendly response: "Vernal has the highest number of stores, with 1 store."

The problem was that I only included 6 stores in my data, each at a different city. So each city I included has 1 store and makes it so all have a tie for the most. Might've only picked Vernal because it was the last store on the list, but this gave me the wrong result.

Zero-shot
The above examples were done using single-domain double-shot.

When using zero-shot, there were a few differences in some of the answers. Such as:



Conclusion
Prompting Strategies: I used zero shot and single domain for this assignment. There is plenty of differences between the two. The single domain response provided more details and was generally more accurate. This is because in the zero shot prompting we are asking it a question without any context or examples. But in the single domain prompt, it is more specific, we give it context to make this response more tailored to our previous prompt questions or insights. I noticed from my model that the zero shot replies from AI generated a more straight to the point answer, while the single domain provided more detail and explanatory work. 
