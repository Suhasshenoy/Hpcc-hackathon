
# Hpcc Systems Hackathon

## Problem statement

[Connections Homes](https://connectionshomes.org/) serves youth 18 – 24 who’ve aged out of foster care or are homeless without family by matching them with a trained and certified Mentoring Family who agrees to be a part of their life, for life, in order to prevent poverty and homelessness and to provide a sense of love and belonging. 

We were given the dataset of mentors who were trained to take care of these youths. Mentors dataset had various fields and each field had a score which denoted their interest for that category.
We had to find best match for a youth based on the rules.

1. Each field had a number from 0 to 5(5 being maximum) on how interested the mentor is to accept a youth who is in that category.

2. If in case youth belonged to a ceratin category and mentor had 0 score in that category , that particular mentor had to be eliminated.

3. Matched mentor should be within the distance specified by the User/Youth

4. If youth doesn't provide information for a particular field, it has to be marked as human review.

## Solution Approach - Team Troubleshooters

1. We made a Roxie query to get the input of the youths to match them to the best mentor

2. We calculated distance of the youth to all the mentors and eliminated the mentors who were in a greater distance than the distance mentioned in the query( inputted by the user)

3. We calculated scores for each field for all the mentors based on the youth information provided.

4. Then calculated total score for each mentor which indicated how well he matched to the youth

5. We then sorted these mentors in decreasing order based on their scores. If in case there was a tie between scores , we prioritized them based on their distance.

6. We then displayed the best mentors list to the user.

## Solution

[Video Explaination](https://www.youtube.com/watch?v=vuapZzsUsfw)

[Presentation](https://docs.google.com/presentation/d/1itl1uWHIJwYm_4pRs8zfFRVT2doOrVWh/edit?usp=sharing&ouid=116259420317309220306&rtpof=true&sd=true)

## Certificate
![Certificate](https://github.com/Suhasshenoy/Hpcc-hackathon/blob/main/Images/certificate.png)
