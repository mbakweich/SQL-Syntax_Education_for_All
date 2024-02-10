select *
from donation_data

select *
from donor_data

--- Assigning Id as the primary key in both tables would enable a JOIN synthax to be used if needed

ALTER TABLE donation_data
ALTER COLUMN id INT NOT NULL

ALTER TABLE donation_data
ADD PRIMARY KEY (id)

ALTER TABLE donor_data
ALTER COLUMN id INT NOT NULL

ALTER TABLE donor_data
ADD PRIMARY KEY (id)

--- Insights and the corresponding syntax required to extract them

---A) How much was the total donations made

SELECT SUM(donation) as total_donations
FROM donation_data;

---B) What was the total donation by gender?
--- This simply involves the use of the group by statement to different the contributions based on gender

SELECT gender, SUM(donation) as total_donations
FROM donation_data
GROUP BY gender;

---C) Show the total donations and number of donations by gender

SELECT gender, SUM(donation) as total_donations, COUNT(donation) as number_of_donations
FROM donation_data
GROUP BY gender;

---D) Show total donations made by frequency of donation

SELECT donation_frequency, SUM(donation) as total_donations
FROM donation_data
JOIN donor_data
ON donation_data.id = donor_data.id
GROUP BY donation_frequency;

---E) Show the Total donations and number of donations by job fields

SELECT job_field, SUM(donation) as total_donation, COUNT(donation) as number_of_donations
FROM donation_data
GROUP BY job_field;

---F) Show the total donations and number of donations above $200

SELECT SUM(donation) as total_donation, COUNT(donation) as number_of_donations
FROM donation_data
WHERE donation > 200;

---G) Show the total donations below $200

SELECT SUM(donation) as total_donation, COUNT(donation) as number_of_donations
FROM donation_data
WHERE donation < 200;

---H) Which top 10 states made the highest donations?

SELECT TOP 10 state, SUM(donation) as total_donation
FROM donation_data
GROUP BY state
ORDER BY SUM(donation) DESC

---I) Which top 10 states contributes the least donations

SELECT TOP 10 state, SUM(donation) as total_donation
FROM donation_data
GROUP BY state
ORDER BY SUM(donation) ASC

----J) What are the top 10 cars driven by the highest donors

SELECT TOP 10 first_name, last_name, donation, donation_frequency, car
FROM donation_data
JOIN donor_data
ON donation_data.id = donor_data.id
WHERE donation_frequency NOT LIKE 'NEVER'
ORDER BY donation DESC
