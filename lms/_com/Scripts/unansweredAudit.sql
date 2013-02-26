DECLARE @unanswerThreshold int;

SET @unanswerThreshold = 10;

WITH CTE_Attendees AS (
	SELECT 
		att.AttendeeID,
		att.ActivityID,
		Per.DisplayName,
		act.Title,
		att.PersonID,
		Result.ResultID,
		Assess.assessmentId,
		Comp.Name As AssessType,
		Result.ResultStatusId,
		Result.created As AssessStartDate,
		ARS.Name As ResultStatus
	FROM ceschema.ce_Attendee AS Att
	INNER JOIN ceschema.ce_Activity AS Act ON Att.ActivityID=Act.ActivityID
	INNER JOIN ceschema.ce_Person AS Per ON Per.personId=Att.personId
	INNER JOIN ceschema.ce_Activity_PubComponent AS Assess ON Assess.ActivityID=Att.ActivityID AND Assess.ComponentID IN (5,11)
	INNER JOIN ceschema.ce_Sys_Component AS Comp ON Comp.ComponentID=Assess.ComponentID
	INNER JOIN ceschema.ce_AssessResult AS Result ON Result.AssessmentID=Assess.AssessmentID AND Result.PersonID=Att.PersonID
	INNER JOIN ceschema.ce_Sys_AssessResultStatus AS ARS ON ARS.ResultStatusID=Result.ResultStatusID
	WHERE 
	Att.StatusID=2 AND 
	Act.StatusID IN (1,2,3) AND 
	Result.ResultStatusID NOT IN (1,3,5) AND /* Don't care if they completed, passed, or failed */
	Act.ActivityTypeID=2 AND 
	Att.DeletedFlag='N' AND
	Act.DeletedFlag='N'
), 

/* SUB TOTALS */
CTE_Stats AS (
	SELECT 
		Atts.*,

		TotalRequiredQ = (SELECT Count(Q.QuestionID) FROM ceschema.ce_AssessQuestion AS Q WHERE (Q.QuestionTypeID NOT IN (5, 6, 7)) AND Q.AssessmentID=Atts.AssessmentID AND Q.RequiredFlag='Y' AND Q.DeletedFlag='N'),
		TotalAnsweredQ = (SELECT Count(A.AnswerID) FROM ceschema.ce_AssessQuestion AS Q INNER JOIN ceschema.ce_AssessAnswer AS A ON A.QuestionID=Q.QuestionID WHERE (Q.QuestionTypeID NOT IN (5, 6, 7)) AND Q.AssessmentID=Atts.AssessmentID AND Q.RequiredFlag='Y' AND Q.DeletedFlag='N' AND A.ResultID=Atts.ResultID AND  A.DeletedFlag='N')
	FROM 
	CTE_Attendees AS Atts
), CTE_Totals AS (

/* TOTALS */		
SELECT 
	ActivityID,
	Title,
	PersonID,
	DisplayName,
	AssessType = CASE 
	WHEN AssessType = 'Assessment (Post)' THEN 'Post Test'
	WHEN AssessType = 'Assessment (Eval)' THEN 'Survey'
	END,ResultStatus,
	ResultInProgressDate = AssessStartDate,
	TotalRequiredQ As TotalQuestions,
	TotalAnsweredQ As TotalAnswered,
	TotalUnanswered = (TotalRequiredQ-TotalAnsweredQ) ,
	TotalPercUnanswered = CASE 
	WHEN TotalAnsweredQ > 0 THEN
		((convert(numeric(5,2),(TotalAnsweredQ))/convert(numeric(5,2),TotalRequiredQ))*100)
	ELSE
		0.0
	END
FROM CTE_Stats AS Atts) 

	/* THRESHOLD FILTER */
	SELECT * FROM CTE_Totals
	WHERE 
	TotalPercUnanswered >= @unanswerThreshold AND AssessType='Survey'
	ORDER BY AssessType DESC,TotalPercUnanswered DESC,Title,ResultInProgressDate