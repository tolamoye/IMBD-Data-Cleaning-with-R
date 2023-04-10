# IMBD-Data-Cleaning-with-R
---
![image](https://user-images.githubusercontent.com/128150171/230795269-40d5cdc1-1f31-40a8-a2cc-d0ed3b54377c.png)

## INTRODUCTION
This is an R project on data cleaning of an **IMBD movie list**. This project is to ensure that the data is accurate, complete and consistent so that it can be used for analysis or other application with confidence in its quality.

## PROBLEM STATEMENT
The dataset contains information about movies such as title ID, release year, genre, duration, country, content rating, director, income, votes, and score. The data is not cleaned and contains several inconsistencies such as different date formats, missing values, and inconsistent values. The problem is to clean and pre-process the data to make it suitable for further analysis. Specifically, the data needs to be standardized to a common format, missing values need to be handled, and inconsistent values need to be corrected. The goal is to create a clean dataset that can be used to analyse the **.IMBD** data. For example:
- The **Release year** column (e.g., '09 21 1972', '22 Feb 04', '10-29-99'), which need to be converted to a consistent format (e.g., 'YYYY-MM-DD') for analysis.
-	Some rows contain missing or invalid data in the **Duration** column (e.g., 'Nan', 'Inf'), which need to be cleaned or imputed to ensure data integrity.
-	The **Genre** column contains multiple genres separated by commas, which need to be split into separate columns to facilitate analysis.
-	The **Content Rating** column contains abbreviated characters which needs to be in their full form for those who would not know the meaning (e.g., 'R', 'Not Rated', 'PG-13', 'Approved') that need to be standardized for analysis.
-	The **Income** column contains dollar signs and commas that need to be removed and the values converted to integers for analysis.
-	The **Votes** column contains commas that need to be removed and the values converted to integers for analysis.
-	The **Score** column contains inconsistent decimal separators (e.g., ',' and '.'), which need to be standardized for analysis.
- Some rows contain missing or invalid data in various columns, which need to be cleaned or imputed to ensure data integrity.

## SKILLS DEMONSTRATED
Data wrangling and cleaning are skills used for this project such as manipulating, reshaping and transforming data into various formats and structures. This project utilizes several R packages including stringr, dplyr, visdat, tidyr, scales, and lubridate to achieve the desired data cleaning tasks. 

## DATA SOURCING
This dataset was acquired from a Twitter user who shared a link to a Google Drive containing the data.

## ASSESSING THE DATA 
The dataset was assessed for abnormalities and data quality. It was noted that all the data are in the character class, and there are some missing values.

**Using visdat to visually show us what our column looks like**

![05 messy_visdat](https://user-images.githubusercontent.com/128150171/230800032-6e5033bc-4526-4d08-a434-a4f639cccae5.png)

**Using vis_guess to ask R to help us look through the data and guess what class they are supposed to belong to**

![06 visguess](https://user-images.githubusercontent.com/128150171/230800034-82a637a3-07c8-470b-a85f-5eecad3f185e.png)

**Using vis_miss to visualize column with missing observations**

![07 vismiss](https://user-images.githubusercontent.com/128150171/230800039-289fff34-0843-4135-acef-32d0973606b1.png)

---

## DATA TRANSFORMATION
When I initially downloaded the dataset, I viewed it in Excel before importing it to R. Since the dataset was in a CSV file format, I converted it to an Excel file. Before cleaning, the dataset had approximately 101 rows and 5 columns. However, after cleaning, one row had no data and was removed, resulting in a total of 100 rows. Additionally, the number of columns increased to 11 because the initial columns were not properly distributed into their appropriate variables. Furthermore, the dataset was only separated by a semicolon instead of being separated by colon, which required additional cleaning steps. You can see view the original data [here](Imbd_messy_data.xlsx)

### Messy table                                                                                                          
![01 Imessy_MBD table](https://user-images.githubusercontent.com/128150171/230797854-53b921a6-e41d-4f32-800c-620a6b00467d.png) 
 
*I combined all columns into a single column using the 'unite' function and used the 'mutate' function to ensure that all delimiters were consistent. Then, I separated the data into their respective column .*

### UNITE

![02 unite](https://user-images.githubusercontent.com/128150171/230800743-6f13156f-6f4a-4419-b6d5-65d3fb675bea.png)

### MUTATE

![03 mutate](https://user-images.githubusercontent.com/128150171/230800762-ea7763aa-4db9-4f8b-aa02-78784c9dfff9.png)

### SEPARATE

![04 seperate](https://user-images.githubusercontent.com/128150171/230800872-8d7fd039-508a-4020-87bf-162130c08bdd.png)

---

## TRANSFORMING THE COLUMNS ONE AFTER THE OTHER

### IMBD TITLE ID
- It has a character of 9 string length and no duplicate.
![09 imbd_titleid](https://user-images.githubusercontent.com/128150171/230798123-481ffa2c-570e-4c30-8116-e97b3220e264.png)

### ORIGINAL TITLE
- Corrected some misspelled words with accented alphabets

Messy                                                                                                          | Cleaned
:-------------------------------------------:                                                                  |:-------------------------------:
![10 messy_Imbdoriginaltitle](https://user-images.githubusercontent.com/128150171/230798215-8f93d3ad-c786-42f1-a99f-40e90c0f85e1.png) | ![11 cleaned_Imbdoriginaltitle](https://user-images.githubusercontent.com/128150171/230798236-ba467bff-4110-447c-a8b0-83de007dc098.png)

### RELEASE YEAR
-	Made the date format consistent
-	Extracted year from the date
-	Manually inserted the correct date gotten from imbd website online to fill the missingness
-	Converted to a numeric class

Messy                                                                                                    | Cleaned
:-------------------------------------------:                                                            |:-------------------------------:
![12 messy_Imbdrelease_year](https://user-images.githubusercontent.com/128150171/230798305-000429fd-5dba-469b-b0bb-20a5abbeeef5.png) |![13 consistency in year](https://user-images.githubusercontent.com/128150171/230798819-1c386d62-3c18-445c-9e41-a5528320dc4f.png)

![14 cleaned_Imbdrelease_year](https://user-images.githubusercontent.com/128150171/230798340-3edb205e-14ed-4330-ad3b-59b1f178c1e6.png)

### GENRE
-	Changed the underscores to commas 

Messy                                                                                                          | Cleaned
:-------------------------------------------:                                                                  |:-------------------------------:
![15 messy_Imbdgenre](https://user-images.githubusercontent.com/128150171/230798874-cfc2db2d-4b69-4afe-bad8-f5269c180e6f.png) | ![16 cleaned_Imbdgenre](https://user-images.githubusercontent.com/128150171/230798902-df394574-8643-4af7-b5db-5a3a5714c451.png)

### DURATION
-	Had 5 NAs, a NaN and an Inf
-	Manually inserted the correct duration from **IMBD** website online to fill the null observations
-	Converted from class character to class numeric 

Messy                                                                                                          | Cleaned
:-------------------------------------------:                                                                  |:-------------------------------:
![17 messy_Imbdduration](https://user-images.githubusercontent.com/128150171/230798920-3f23e054-90fe-4657-821c-6f8d16bf6ddf.png) |![18 na, nana inf of Duration](https://user-images.githubusercontent.com/128150171/230799411-52a4719f-d6bd-437e-9837-2b2b5e50b5ca.png)

![19 cleaned_imbdduration](https://user-images.githubusercontent.com/128150171/230798932-b14ef38f-051a-43e4-82da-51e671d00257.png)

### COUNTRY
-	Corrected the misspelled country names

Messy                                                                                                          | Cleaned
:-------------------------------------------:                                                                  |:-------------------------------:
![20 messy_Imbdcountry](https://user-images.githubusercontent.com/128150171/230798567-b79a7a7e-6f69-45db-8b97-87be409602b0.png) | ![21 cleaned_Imbdcountry](https://user-images.githubusercontent.com/128150171/230798575-4458ad82-bc7a-4c7c-babd-e4f7e9ced7a1.png) 

### CONTENT RATING
-	Replaced the abbreviated content rating to its full form
-	Converted to a factor since it is a categorical data having a total of **6 levels**

Messy                                                                                                          | Cleaned
:-------------------------------------------:                                                                  |:-------------------------------:
![22 messy_Imbdcontent_rating](https://user-images.githubusercontent.com/128150171/230798590-bcb654b5-cae8-414c-99ad-2978345dc33d.png) | ![23 cleaned_Imbdcontent_rating](https://user-images.githubusercontent.com/128150171/230798594-a3d1053d-18be-440a-a9f0-d454cfc1e46e.png)

![24 factor level content rating](https://user-images.githubusercontent.com/128150171/230799492-21dd0b8d-8b28-43d7-b9e2-c0d568ede1d8.png)

### DIRECTOR
-	Changed accented alphabet to a proper alphabet,
-	Replaced underscore with comma where we have more than a director

Messy                                                                                                          | Cleaned
:-------------------------------------------:                                                                  |:-------------------------------:
![25 messy_Imbddirector](https://user-images.githubusercontent.com/128150171/230798632-c8f633ec-d245-4d10-ac14-3f8f2cd94800.png) | ![26 cleaned_Imbddirector](https://user-images.githubusercontent.com/128150171/230798637-5038ba33-a366-4d85-b197-91e9ebc2c882.png)

### INCOME
-	Removed the dollar sign to be able to convert to a numeric class,
-	Renamed the column to **income_usd** to indicate that it is in dollar format

Messy                                                                                                          | Cleaned
:-------------------------------------------:                                                                  |:-------------------------------:
![27 messy_Imbdincome](https://user-images.githubusercontent.com/128150171/230798659-1b98d391-2d76-47fa-81c9-094d86abc75a.png) | ![28 cleaned_Imbdincome](https://user-images.githubusercontent.com/128150171/230798664-54e592f7-b405-4ede-9b02-a847b0de6591.png)

### VOTES
-	Removed non numeric characters (.)  and converted to a numeric data

Messy                                                                                                          | Cleaned
:-------------------------------------------:                                                                  |:-------------------------------:
![29 messy_Imbdvote](https://user-images.githubusercontent.com/128150171/230798696-b86d4822-851d-418a-903e-0cd6dd299a93.png) | ![30 cleaned_Imbdvotes](https://user-images.githubusercontent.com/128150171/230798719-725d656f-1d92-4ba9-8f17-88eefdd776fb.png)

### SCORE
-	Removed non-alphabetical characters,
-	Removed leading 0,
-	Added decimal points to those without,
-	Removed extra decimal point,,
-	Converted to numeric data

Messy                                                                                                          | Cleaned
:-------------------------------------------:                                                                  |:-------------------------------:
![31 messy_Imbdscore](https://user-images.githubusercontent.com/128150171/230798979-1a280b92-624c-43f6-9fd5-0c73a71df285.png) | ![32 cleaned_Imbdscore](https://user-images.githubusercontent.com/128150171/230799016-8aa6bf32-f0b9-4a5f-a14b-074abe5fc685.png)

### CLEANED TABLE
![33 cleaned_table](https://user-images.githubusercontent.com/128150171/230797913-88339da8-6dba-41cb-8be1-ca3d1855f138.png)
You can view the cleaned data [here](Imbd_cleaned_data.xlsx)

**Now we are checking to confirm there are no missing observation**

![34 cleaned vismiss](https://user-images.githubusercontent.com/128150171/230800242-dc27c161-f696-4c20-8390-e59ec65d2ac5.png)

**Now we are using the vis_guess to check if they are in their right classes**

![35 cleaned visguess](https://user-images.githubusercontent.com/128150171/230800249-10b890e3-5f72-47f9-92a9-a172fced4854.png)

## LIMITATIONS
The cleaning process for the dataset has some limitations that should be noted. Manually inserting data slowed down the cleaning process and may introduce errors or biases in the data if not done carefully. Additionally, some columns in the dataset have missing values or incomplete data, which may limit the analysis that can be conducted. In terms of the nature of the dataset, there are also some limitations to consider. The dataset only includes information about the top-rated movies on *IMBD*, which is a relatively small subset of all movies ever made, making it limited in scope. Additionally, the dataset is based on user ratings, which could potentially affect the representativeness of the sample and the accuracy of the ratings due to biases from self-selection, non-response, and rating manipulation. Lastly, the dataset only includes movies up to a certain point in time and may not reflect more recent trends or changes in the movie industry

## CONCLUSION AND RECOMMENDATION
After cleaning the dataset, few out of the many insights that can be obtained for instance are : *The Lord of the Rings trilogy has three movies in the top 15, with The Return of the King having the highest score of 8.9. The top-rated movies are mostly crime and drama, followed by action and adventure, and are mainly from the United States. The content ratings of top-rated movies vary, with R being the most common, followed by PG-13 and PG. Interestingly, there is no clear correlation between a movie's income and its rating, as some high-rated movies had a low income, while some lower-rated movies had a high income. Furthermore, the number of votes for a movie is positively correlated with its rating, indicating that popular movies tend to have higher ratings. Overall, the top-rated movies in the dataset are diverse in terms of styles, genres, and origins, suggesting that there is no single formula for making a highly-rated movie.* Finally, the purpose of data cleaning is to ensure the accuracy, consistency, and completeness of the data, which can help prevent errors and enable more accurate analyses and predictions.
---
You can view the step-by-step process I followed to clean the data [here](IMBD_Cleaning.R)





 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

























