# Usage / Deployment notes


## Prerequisites


- Azure subscription
- Azure SQL server and database
- Office365 mailbox with application permission (or use a shared mailbox)
- Azure Form Recognizer resource (or Cognitive Services)
- (Optional) API Management instance


## Quick steps


1. Run `sql/init.sql` on your Azure SQL to create the `Documents` table.
2. Create a Logic App (Consumption) and import `logicapp/workflow.json` in Code View.
3. Configure connectors (Office365, SQL, Form Recognizer) in the Logic App's Connections page.
4. Test by sending an email with a PDF attachment to the monitored mailbox.
5. Optionally import the Logic App into APIM and attach `apim/policy.xml`.


## Mapping advice


- `Parse_Extraction` outputs raw Form Recognizer JSON. Map fields specifically in the Logic App using `Compose` + `json()` and/or `xpath()` depending on which recognizer you use.


## Security


- Use Managed Identity and private endpoints for production.
- Do not expose the Logic App trigger URL publicly; use APIM in front and restrict logic app access if possible.
