Notes from SULI deliverable meeting:
* 6 required deliverables
  * Pre-Survey (due July 9)
  * General Audience abstract (not CCI)
    * 300 word essay written to be read by a lay audience
    * Not a technical abstract
    * Like an extended elevator talk.  Very informal
    * Explains the connection to DOE/NLR, the research, and impact.
    * Submitted for review and feedback
    * Examples and templates are available on Canvas
    * Upload in a Work Document.
  * Research paper
    * AIP formatting
    * Metnor should edit the paper and give approval for it.
    * Examples and templates on Cavnas along with feedback.
  * Research poster
    * Summarize your research project including:
      * problem statement
      * research methods
      * result and conclusions
    * Presented to a large group, so keep in gneral 
    * Paper and poster must include stuff ...
  * Poster peer review (not CCI)
    * We have to review oone poster of another intern.
  * post-survey
* Final deliverables must be uploaded to WARS by September 30, 10 pm MT.
* Required to atten all Professional Development meetings
  * Meetings that go over how to complete the deliverables.
  * Consier using Zotero



Updates on Info:
* the OAI_CAUSAL_TRACE.md is a file that reads the oai-amf logs and keeps them inside it.  The openclaw AI agent can read the OAI_CAUSAL_TRACE.md file, but not the oai-amf logs directly (I think).
* To check the oai-amf logs, simply type "docker logs oai-amf" into the terminal in the badgers-based-lab directory.



Problems with AI:
* It seems that the AI is reaching out to the model that we downloaded, the nemotron-3-super:120b, but is getting no response.  The AI is then hanging indefinitely regardless of what the task is, trying to ask the model again and again for a response.
* This is why it is always reasoning but processing stuff from forever ago still.
* Need to find out why there is a disconnect.