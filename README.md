# PdfExtractDemo
## Azure Logic App + APIM — PDF Extract Demo
Example repository for a lab: receive a PDF by email, extract information (with Form Recognizer / OCR) and save it to Azure SQL, in addition to publishing the Logic App to APIM.
## Components


- Logic App (Consumption): `logicapp/workflow.json`
- APIM policy example to front the Logic App: `apim/policy.xml`
- SQL schema: `sql/init.sql`
- A small test script that uses `sendmail` or `mail` to simulate sending an email with attachment: `scripts/test-send-email.sh`
- Deployment parameters sample: `deploy/parameters.sample.json`


## How to use (high level)


1. Create resources in Azure: Resource Group, Azure SQL, Logic App (Consumption), API Management (optional), Form Recognizer / Cognitive Services.
2. Run SQL schema in your Azure SQL.
3. Import `logicapp/workflow.json` into a new Logic App using the Azure Portal ("Logic App Designer" -> Code view -> paste). Configure connections for Office365 (or Outlook), SQL, and Form Recognizer.
4. Test by sending an email with a sample PDF attachment to the monitored mailbox. The Logic App will extract fields and insert a row on the `Documents` table.
5. (Optional) Import the Logic App into APIM and attach the policy in `apim/policy.xml` to add authentication and rate-limiting.


## Notes


- This is a **lab**: adapt security (VNET, Managed Identity, private endpoints) for production.
- Replace the Form Recognizer connector call with Computer Vision OCR if you prefer.

