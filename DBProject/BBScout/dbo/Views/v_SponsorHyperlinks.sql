


-- View for Sponsors
CREATE view [dbo].[v_SponsorHyperlinks] as
select case when ts.sameLineAsPrevious = 'N'
	        then '<p></p>'
			else '' end +
       case when ts.referenceURL is not null and ts.logoFile is not null
	        then '<a href="' + ts.referenceURL + '" target="_blank"><img class="image' + ltrim(convert(nvarchar, ts.sortOrder)) + '" src="' + ts.logoFile + '" ' +
			                                                                                                      case when ts.width is not null and ts.height is not null
			                                                                                                           then 'style="border:0px solid black;" width="' + convert(varchar, ts.width) + '" height="' + convert(varchar, ts.height) + '"'
																													   else 'style="border:0px solid black; max-width: ' + convert(varchar, ts.maxWidthPercent) end + '%' +
																												  case when ts.sameLineAsPrevious = 'Y'
																												       then '; padding-left: 30px"'
																													   else '"' end +
																												  '></a>'
			when ts.logoFile is not null
	        then '<img class="image' + ltrim(convert(nvarchar, ts.sortOrder)) + '" src="' + ts.logoFile + '" ' + 
			                                                                                                      case when ts.width is not null and ts.height is not null
			                                                                                                           then 'style="border:0px solid black;" width="' + convert(varchar, ts.width) + '" height="' + convert(varchar, ts.height) + '"'
																													   else 'style="border:0px solid black; max-width: ' + convert(varchar, ts.maxWidthPercent) end + '%' +
																												  case when ts.sameLineAsPrevious = 'Y'
																												       then '; padding-left: 30px"'
																													   else '"' end +
																												  '>'
	        when ts.referenceURL is not null
	        then '<a href="' + ts.referenceURL + '" target="_blank">' + ts.sponsorName + '</a>'
			else '<b><font size="4">' + ts.SponsorName + '</font></b>' end sponsorHTML
     , ts.sortOrder
	 , ge.loginGUID
  from TeamSponsor ts
       inner join Team t
	   on t.id = ts.teamId
	   inner join Game g
	   on g.id = ts.gameId
       inner join v_GameEvent ge
	   on ge.id = t.gameEventId
	   and ge.gameId = g.id